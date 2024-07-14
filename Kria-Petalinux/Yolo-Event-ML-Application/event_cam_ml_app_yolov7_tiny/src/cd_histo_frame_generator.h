#ifndef METAVISION_SDK_CORE_CD_FRAME_GENERATOR_H
#define METAVISION_SDK_CORE_CD_FRAME_GENERATOR_H

#include "metavision/sdk/base/events/event_cd.h"
#include "periodic_histo_frame_generation_algorithm.h"
#include "metavision/sdk/core/utils/threaded_process.h"

namespace Metavision {

/// @brief Utility class to display CD events that handles multithreading and is built on the top
/// of PeriodicFrameGenerator
class CDHistoFrameGenerator {
public:
    /// @brief Default constructor
    /// @param width Width of the image (in pixels)
    /// @param height Height of the image (in pixels)
    /// @param process_all_frames If true, it will process all frames, not just the latest one. Note that if true
    /// it can slow down the process.
    CDHistoFrameGenerator(long width, long height, bool process_all_frames = false);

    /// @brief Destructor
    ~CDHistoFrameGenerator();

    
    /// @brief Adds the buffer of events to be displayed
    /// @param begin Beginning of the buffer of events
    /// @param end End of the buffer of events
    void add_events(const Metavision::EventCD *begin, const Metavision::EventCD *end);

    /// @brief Sets the time interval to display events
    ///
    /// The events shown at each refresh are such that their timestamps are in the last 'display_accumulation_time_us'
    /// microseconds from the last received event timestamp.
    ///
    /// @param display_accumulation_time_us The time interval to display events from up to now (in us).
    void set_display_accumulation_time_us(timestamp display_accumulation_time_us);

    /// @brief Starts the generator thread
    ///
    /// @param fps Frame rate
    /// @param cb Function to call every time a new frame is available. It takes in input the time (in us) of the new
    /// frame and the frame. The frame passed as a parameter is guaranteed to be available and left untouched until the
    /// next time the callback is called. This means that you don't need to make a deep copy of it, if you only intend
    /// to use the frame until the next one is made available by the callback.
    /// @return true if the thread started successfully, false otherwise. Also returns false, if the thread is already
    /// started.
    bool start(std::uint16_t fps, const PeriodicHistoFrameGenerationAlgorithm::OutputCb &cb);

    /// @brief Stops the generator thread
    ///
    /// @return true if the thread has been stopped successfully, false otherwise. Return false if the thread had not
    /// been previously started
    bool stop();

    /// @brief Resets the frame generator state
    void reset();

private:
    bool generate();

    // Image to display
    PeriodicHistoFrameGenerationAlgorithm::OutputCb frame_cb_;

    struct FrameEvent {
        cv::Mat frame_;
        timestamp ts_us_;
    };
    std::vector<FrameEvent> frames_;
    std::vector<EventCD> events_front_, events_back_;
    size_t frames_count_{0};

    // Is frame dropping allowed?
    bool process_all_frames_ = false;
    bool events_available_   = false;
    timestamp notify_slice_us_{0};
    timestamp next_notify_us_;

    // Events to display
    std::mutex processing_mutex_;
    std::atomic<bool> stop_{true};
    std::condition_variable events_available_cond_;

    std::unique_ptr<PeriodicHistoFrameGenerationAlgorithm> frame_generation_algo_;
    // Shadow params
    timestamp accumulation_time_us_;
    cv::Scalar background_color_, on_color_, off_color_;
    bool colored_;

    ThreadedProcess processing_thread_;
};

} // namespace Metavision

#endif // METAVISION_SDK_CORE_CD_FRAME_GENERATOR_H