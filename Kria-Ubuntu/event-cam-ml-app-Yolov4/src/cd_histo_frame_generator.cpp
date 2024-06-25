#include "cd_histo_frame_generator.h"
// #include "metavision/sdk/core/utils/colors.h"
#include "periodic_histo_frame_generation_algorithm.h"
#include "metavision/sdk/base/utils/timestamp.h"

namespace Metavision {

CDHistoFrameGenerator::CDHistoFrameGenerator(long width, long height, bool process_all_frames) :
    process_all_frames_(process_all_frames) {
    // Builds algo
    bool enable_histo, enable_diff, diff_allow_rollover, histo_packed=0, disable_display;
    unsigned int histo_bit_size_neg = 4, histo_bit_size_pos=4, diff_bit_size=8;
    int nevents = -1;

    // we also need to choose an accumulation time and a frame rate (here of 20ms and 50 fps)
    const std::uint32_t acc = 10000;
    double fps              = 100;
    Metavision::timestamp period_us = 10000, min_generation_period_us = 0;

    frame_generation_algo_.reset(new PeriodicHistoFrameGenerationAlgorithm(width, height, acc, fps, 
                                                                      width, height,
                                                                      histo_bit_size_neg, histo_bit_size_pos, histo_packed,
                                                                       min_generation_period_us));

    // Update accumulation time
    set_display_accumulation_time_us(frame_generation_algo_->get_accumulation_time_us());
    next_notify_us_ = notify_slice_us_;

}

CDHistoFrameGenerator::~CDHistoFrameGenerator() {
    stop();
}


void CDHistoFrameGenerator::add_events(const EventCD *begin, const EventCD *end) {
    if (begin == end) {
        return;
    }

    if (stop_ && !process_all_frames_) {
        // if the generator is not yet started and we don't have to process all frames, we don't need to keep the events
        return;
    }

    std::lock_guard<std::mutex> lock(processing_mutex_);
    // Note: one could call frame_generation_algorithm->process_events directly but it may have a high overhead
    // depending on the inputs.and decreases the performance. Better ensure that bigger chunks of data are processed
    events_back_.insert(events_back_.end(), begin, end);
    if (std::prev(end)->t > next_notify_us_) {
        events_available_ = true;
        next_notify_us_   = notify_slice_us_ * (1 + begin->t / notify_slice_us_);
        events_available_cond_.notify_all();
    }
}

void CDHistoFrameGenerator::set_display_accumulation_time_us(timestamp display_accumulation_time_us) {
    std::lock_guard<std::mutex> lock(processing_mutex_);
    accumulation_time_us_ = display_accumulation_time_us;
    notify_slice_us_      = std::max(timestamp(100), display_accumulation_time_us / 3);
}

bool CDHistoFrameGenerator::generate() { //update generate function with arguments to pass ts
    {
        std::unique_lock<std::mutex> lock(processing_mutex_);
        events_available_cond_.wait(lock, [this]() { return events_available_ || stop_; });
        events_front_.clear();
        events_front_.swap(events_back_);
        events_available_ = false;

        frame_generation_algo_->set_accumulation_time_us(accumulation_time_us_);
        
    }

    if (!process_all_frames_ && !events_front_.empty()) {
        // Generates only the last possible frame
        frame_generation_algo_->skip_frames_up_to(events_front_.back().t);
    }

    frame_generation_algo_->process_events(events_front_.cbegin(), events_front_.cend());
    if (stop_) {
        frame_generation_algo_->force_generate(); //to do change to generate
    }

    for (size_t i = 0; i < frames_count_; ++i) {
        // If process_all_frames is false, frames_count is 1 at most
        frame_cb_(frames_[i].ts_us_, frames_[i].frame_);
    }
    frames_count_ = 0;

    return !stop_;
}

bool CDHistoFrameGenerator::start(std::uint16_t fps, const PeriodicHistoFrameGenerationAlgorithm::OutputCb &cb) {
    auto ret = processing_thread_.start();
    if (!ret) {
        return false;
    }

    // Init algos and state variables
    frame_generation_algo_->reset();
    frame_generation_algo_->set_fps(fps);
    frame_cb_ = cb ? cb : [](auto, auto) {};

    frame_generation_algo_->set_output_callback([this](timestamp frame_ts_us, cv::Mat &mat) {
        if (frames_count_ == frames_.size()) {
            frames_.resize(frames_.size() + 1);
        }
        std::swap(frames_[frames_count_].frame_, mat);
        frames_[frames_count_].ts_us_ = frame_ts_us;
        ++frames_count_;
    });

    stop_ = false;

    processing_thread_.add_repeating_task(std::bind(&CDHistoFrameGenerator::generate, this));

    return true;
}

bool CDHistoFrameGenerator::stop() {
    stop_ = true;
    events_available_cond_.notify_all();
    if (process_all_frames_) {
        processing_thread_.stop();
    } else {
        processing_thread_.abort();
    }

    frames_.clear();
    frames_.shrink_to_fit();
    frames_count_ = 0;

    return true;
}

void CDHistoFrameGenerator::reset() {
    std::lock_guard<std::mutex> lock(processing_mutex_);
    frame_generation_algo_->reset();
    events_back_.clear();
    next_notify_us_ = notify_slice_us_;
}

} // namespace Metavision