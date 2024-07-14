#include <stdexcept>
#include "periodic_histo_frame_generation_algorithm.h"

namespace Metavision {

PeriodicHistoFrameGenerationAlgorithm::PeriodicHistoFrameGenerationAlgorithm(int sensor_width, int sensor_height,
                                                                   uint32_t accumulation_time_us, double fps,
                                                                   unsigned int width, unsigned int height, unsigned int channel_bit_neg,
                                                                   unsigned int channel_bit_pos, bool packed ,
                                                                   timestamp min_generation_period_us) :
    sum_max_neg_((1 << channel_bit_neg) - 1),
    sum_max_pos_((1 << channel_bit_pos) - 1),
    cfg_({width, height, {channel_bit_neg, channel_bit_pos}, packed}),
    min_generation_period_us_(min_generation_period_us),
    frame_unpacked_(height, width, channel_bit_neg, channel_bit_pos, false) ,
    output_cb_([](auto, auto) {}),
    reslicer_([&](EventBufferReslicerAlgorithm::ConditionStatus slicing_status, timestamp processing_ts,
                  std::size_t n_processed_events) {
        this->process_new_slice(slicing_status, processing_ts, n_processed_events);
    }),
    force_next_frame_(false) {
        set_accumulation_time_us(accumulation_time_us);
        set_fps(fps);
        reset();
    }


void PeriodicHistoFrameGenerationAlgorithm::set_output_callback(const OutputCb &output_cb) {
    output_cb_ = output_cb;
}

void PeriodicHistoFrameGenerationAlgorithm::notify_elapsed_time(timestamp ts) {
    reslicer_.notify_elapsed_time(ts);
}

void PeriodicHistoFrameGenerationAlgorithm::force_generate() {
    force_next_frame_ = true;
    reslicer_.flush();
    force_next_frame_ = false;
}

void PeriodicHistoFrameGenerationAlgorithm::set_fps(double fps) {
    if (fps < 0)
        throw std::invalid_argument("Frame rate must be positive.");

    // Computes the frame period from the input fps. If the input fps is 0, then the frame period
    // is the accumulation time.
    if (fps == 0)
        frame_period_us_ = accumulation_time_us_;
    else
        frame_period_us_ = static_cast<uint32_t>(std::round(1000000. / fps));

    reslicer_.set_slicing_condition(EventBufferReslicerAlgorithm::Condition::make_n_us(frame_period_us_));
}

double PeriodicHistoFrameGenerationAlgorithm::get_fps() {
    return 1000000. / frame_period_us_;
}

void PeriodicHistoFrameGenerationAlgorithm::set_accumulation_time_us(uint32_t accumulation_time_us) {
    if (accumulation_time_us <= 0)
        throw std::invalid_argument("Accumulation time must be strictly positive.");

    accumulation_time_us_   = accumulation_time_us;
    min_event_ts_us_to_use_ = next_frame_ts_us_ - accumulation_time_us_;
}

uint32_t PeriodicHistoFrameGenerationAlgorithm::get_accumulation_time_us() {
    return accumulation_time_us_;
}

void PeriodicHistoFrameGenerationAlgorithm::reset() {
    reslicer_.reset();

    // reset_time_surface();
    next_frame_ts_us_ = 0;

    min_event_ts_us_to_use_ = 0;

    frame_unpacked_.reset();
    is_ts_prev_set_ = false;
}

void PeriodicHistoFrameGenerationAlgorithm::process_new_slice(EventBufferReslicerAlgorithm::ConditionStatus slicing_status,
                                                         timestamp processing_ts, size_t n_processed_events) {
    if (processing_ts < next_frame_ts_us_ && !force_next_frame_)
        return;

    
    cv::Mat visu_histo, combined_frame(cfg_.height, cfg_.width, CV_8UC3);
    visu_histo = combined_frame(cv::Rect(0, 0, cfg_.width, cfg_.height));
    
    RawEventFrameHisto frame;
    frame.reset(cfg_.height, cfg_.width, cfg_.channel_bit_size[0], cfg_.channel_bit_size[1],
                    cfg_.packed);    // Prepare next accumulating frame
    frame.swap(frame_unpacked_); // Swap internal event frame with provided one

    // Compute the time threshold below which events are not to be displayed
    // N.B. min_event_ts_us_to_use_ might be wrong at the initialization.
    //      Let's subtract the accumulation time to the current processing timestamp
    const int32_t min_display_event_ts = static_cast<int32_t>((processing_ts - accumulation_time_us_) - ts_offset_);
    
    
    for (int y = 0; y < cfg_.height; ++y) {
        auto it_histo_line_neg = frame.get_data().cbegin() + y * cfg_.width * 2;
        auto it_histo_line_pos = frame.get_data().cbegin() + y * cfg_.width * 2 + 1;
        for (int i = 0; i < cfg_.width; ++i) {
            visu_histo.ptr<cv::Vec3b>(y)[i] = cv::Vec3b(it_histo_line_neg[2 * i]*17,  it_histo_line_pos[2 * i]*17, 0);
        }
    }


    // Return generate frame through the output callback
    output_cb_(processing_ts, visu_histo);
    // output_cb_(processing_ts, frame_unpacked_);

    // Increment internal variables
    next_frame_ts_us_       = processing_ts + frame_period_us_;
    min_event_ts_us_to_use_ = next_frame_ts_us_ - accumulation_time_us_;
}

void PeriodicHistoFrameGenerationAlgorithm::skip_frames_up_to(timestamp ts) {
    next_frame_ts_us_ =
        std::max(next_frame_ts_us_, static_cast<timestamp>(frame_period_us_) *
                                        static_cast<timestamp>(ts / static_cast<double>(frame_period_us_)));
    min_event_ts_us_to_use_ = next_frame_ts_us_ - accumulation_time_us_;
}

void PeriodicHistoFrameGenerationAlgorithm::reset_time_surface() {
    // time_surface_.resize(width_ * height_);
    std::fill(time_surface_.begin(), time_surface_.end(), std::make_pair(std::numeric_limits<int32_t>::min(), false));
    ts_offset_ = 0;
}

void PeriodicHistoFrameGenerationAlgorithm::generate(RawEventFrameHisto &frame) {
    if (cfg_.packed) {
        frame.reset(cfg_.height, cfg_.width, cfg_.channel_bit_size[0], cfg_.channel_bit_size[1],
                    cfg_.packed); // Prepare target frame
        auto &histo_out      = frame.get_data();
        auto &histo_unpacked = frame_unpacked_.get_data();
        for (unsigned int npixels = cfg_.width * cfg_.height, idx_px = 0; idx_px < npixels; ++idx_px) {
            const uint8_t bitval_neg = histo_unpacked[2 * idx_px];
            const uint8_t bitval_pos = histo_unpacked[2 * idx_px + 1];
            histo_out[idx_px]        = (bitval_pos << cfg_.channel_bit_size[0]) | (bitval_neg);
        }
        frame_unpacked_.reset(); // Prepare next accumulating frame
    } else {                                                                                     //since we are doing for unpacked so generate will not be needed we directly used frame_unpacked_ value accumulated in this class
        frame.reset(cfg_.height, cfg_.width, cfg_.channel_bit_size[0], cfg_.channel_bit_size[1],
                    cfg_.packed);    // Prepare next accumulating frame
        frame.swap(frame_unpacked_); // Swap internal event frame with provided one
    }
}

bool PeriodicHistoFrameGenerationAlgorithm::generate(timestamp ts_event_frame, RawEventFrameHisto &event_frame) {
    if (is_ts_prev_set_ && ts_event_frame - ts_prev_ < min_generation_period_us_)
        return false;
    is_ts_prev_set_ = true;
    ts_prev_        = ts_event_frame;
    generate(event_frame);
    return true;
}

} // namespace Metavision
