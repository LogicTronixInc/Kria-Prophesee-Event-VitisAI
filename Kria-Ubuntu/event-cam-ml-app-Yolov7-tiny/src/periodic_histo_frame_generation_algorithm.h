
#ifndef METAVISION_SDK_CORE_PERIODIC_FRAME_GENERATION_ALGORITHM_H
#define METAVISION_SDK_CORE_PERIODIC_FRAME_GENERATION_ALGORITHM_H

#include <functional>

#include "metavision/sdk/core/algorithms/base_frame_generation_algorithm.h"
#include "metavision/sdk/core/algorithms/event_buffer_reslicer_algorithm.h"
#include "metavision/sdk/base/utils/timestamp.h"
#include "metavision/sdk/base/events/event_cd.h"
#include "metavision/sdk/base/events/raw_event_frame_histo.h"

namespace Metavision {

class PeriodicHistoFrameGenerationAlgorithm;

/// @brief Algorithm that generates frames from events at a fixed rate (fps). The reference clock used is the one of
/// the input events.
///
/// As an asynchronous algorithm, this class processes any stream of events and triggers the frames generation by
/// itself to output frames regularly spaced in time through its output callback. Note that the implementation of this
/// class uses EventBufferReslicerAlgorithm in place of AsyncAlgorithm, with the same overall behavior.
///
/// The elapsed time between two frame generations (frame period = 1 / fps) and the accumulation time can be updated
/// on the fly.
///
/// This class should be used when the user prefers to register to an output callback than having to manually ask the
/// algorithm to generate the frames for increasing multiples of the frame period.
/// However, this class shouldn't be used in case the user wants to generate a frame inside the callback of an
/// algorithm (See @ref OnDemandFrameGenerationAlgorithm)
class PeriodicHistoFrameGenerationAlgorithm {
public:
    /// @brief Alias for frame generated callback
    using OutputCb = std::function<void(timestamp, cv::Mat &)>;
    // using OutputCb = std::function<void(timestamp, RawEventFrameHisto &)>;

    /// @brief Constructor
    /// @param sensor_width Sensor's width (in pixels)
    /// @param sensor_height Sensor's height (in pixels)
    /// @param accumulation_time_us Time range of events to update the frame with (in us)
    /// @param fps The fps at which to generate the frames. The time reference used is the one from the input events. If
    /// the fps is 0, the accumulation time is used to compute it (@ref set_fps).
    /// @param palette The Prophesee's color palette to use (@ref set_color_palette)
    /// @throw std::invalid_argument If the input fps is negative
    PeriodicHistoFrameGenerationAlgorithm(int sensor_width, int sensor_height,
                                        uint32_t accumulation_time_us, double fps,
                                        unsigned int width, unsigned int height, unsigned int channel_bit_neg,
                                        unsigned int channel_bit_pos, bool packed ,
                                        timestamp min_generation_period_us );

    /// @brief Sets the callback to call when an image has been generated
    ///
    /// @warning For efficiency purpose, the frame passed in the callback is a non const reference. If it is to be
    /// used outside the scope of the callback, the user must ensure to swap or copy it to another object
    void set_output_callback(const OutputCb &output_cb);

    /// @brief Processes a buffer of events to update the internal time surface for the frame generation
    /// @tparam InputIt Read-Only input event iterator type. Works for iterators over buffers of @ref EventCD
    /// or equivalent
    /// @param it_begin Iterator to the first input event
    /// @param it_end Iterator to the past-the-end event
    template<typename EventIt>
    inline void process_events(EventIt it_begin, EventIt it_end);

    /// @brief Notify the frame generator that time has elapsed without new events, which may trigger several calls
    /// to the image generated callback depending on the configured slicing condition.
    /// @param ts current timestamp
    void notify_elapsed_time(timestamp ts);

    /// @brief Forces the generation of a frame for the current period with the input events that have been processed
    ///
    /// This is intended to be used at the end of a process if one wants to generate frames with the remaining events
    /// This effectively calls the output_cb and updates the next timestamp at which a frame is to be generated
    void force_generate();

    /// @brief Sets the fps at which to generate frames and thus the frequency of the asynchronous calls
    ///
    /// The time reference used is the one from the input events
    ///
    /// @param fps The fps to use. If the fps is 0, the current accumulation time is used to compute it
    /// @throw std::invalid_argument If the input fps is negative
    void set_fps(double fps);

    /// @brief Returns the current fps at which frames are generated
    double get_fps();

    /// @brief Sets the accumulation time (in us) to use to generate a frame
    ///
    /// Frame generated will only hold events in the interval [t - dt, t[ where t is the timestamp at
    /// which the frame is generated, and dt the accumulation time
    ///
    /// @param accumulation_time_us Time range of events to update the frame with (in us)
    void set_accumulation_time_us(uint32_t accumulation_time_us);

    /// @brief Returns the current accumulation time (in us).
    uint32_t get_accumulation_time_us();

    /// @brief Skips the generation of frames up to the timestamp @p ts
    /// @param ts Timestamp up to which only one image will be generated, i.e. the closest full timeslice
    /// before this timestamp
    void skip_frames_up_to(timestamp ts);

    /// @brief Resets the internal states
    /// @warning the user is responsible for explicitly calling @ref force_generate if needed to retrieve the frame for
    /// the last processed events.
    void reset();

    /// @brief Retrieves the histo event frame aggregating events since the last call to @p generate, and resets the
    /// aggregation for upcoming calls to @p process_events.
    /// @param event_frame histo event frame.
    /// @note in packed mode, a packed copy of the accumulation data will be returned, incurring a slight performance
    /// cost compared to unpacked mode.
    /// @note This version of the function does not simulate the limited transfer bandwidth typically met on hardware
    /// implementations and hence ignores the practical lower-bound on event frame generation frequency.
    void generate(RawEventFrameHisto &event_frame);

    /// @brief Retrieves the diff event frame aggregating the events processed so far, and resets the
    /// aggregation for upcoming calls to @p process_events. This version of the function simulates the limited transfer
    /// bandwidth typically met on hardware implementations and hence may fail to retrieve the event frame. Internal
    /// counters are only reset if the event frame retrieval is successful.
    /// @param ts_event_frame diff event frame.
    /// @param event_frame diff event frame.
    /// @return False if the time since the last call to generate is below the lower-bound generation period, true
    /// otherwise.
    bool generate(timestamp ts_event_frame, RawEventFrameHisto &event_frame);


private:
    template<typename EventIt>
    inline void process_event_buffer(EventIt it_begin, EventIt it_end);

    /// @brief Generates a frame from the events history and accumulation time
    ///
    /// This method is called at the input fps frequency
    void process_new_slice(EventBufferReslicerAlgorithm::ConditionStatus slicing_status, timestamp processing_ts,
                           size_t n_processed_events);

    /// @brief Resets the time surface
    void reset_time_surface();

    OutputCb output_cb_; ///< The callback to call when a frame is generated

    EventBufferReslicerAlgorithm reslicer_; ///< Event buffer reslicer algorithm.

    cv::Mat frame_;            ///< Internal image that is filled when asynchronous condition is met
    uint32_t frame_period_us_; ///< Period (in us) between two frames generation (i.e. period between two calls to
                               ///< asynchronous processing calls). The period is measured with the input events'
                               ///< timestamp

    uint32_t accumulation_time_us_;    ///< Accumulation time of the events to generate the frame
    timestamp next_frame_ts_us_;       ///< The next frame generated timestamp
    timestamp min_event_ts_us_to_use_; ///< The lower bound of time interval of events to process

    bool force_next_frame_; ///< Flag indicating if the next frame must be generated no matter the timestamp of the
                            /// processed time slice

    // Time surface
    std::vector<std::pair<int32_t, bool>> time_surface_; ///< Pixels' history (time surface). This object stores the
                                                         ///< last events data that occurred at a given pixel

    const uint8_t sum_max_neg_, sum_max_pos_;
    const RawEventFrameHistoConfig cfg_;
    const timestamp min_generation_period_us_;
    bool is_ts_prev_set_ = false;
    timestamp ts_prev_;
    RawEventFrameHisto frame_unpacked_;
    timestamp ts_offset_{0}; ///< State variable to handle time overflow in the time surface. This is to minimize the
                             ///< memory footprint of the time surface access
};

template<typename EventIt>
void PeriodicHistoFrameGenerationAlgorithm::process_events(EventIt it_begin, EventIt it_end) {
    reslicer_.process_events(it_begin, it_end,
                             [&](EventIt it_begin, EventIt it_end) { this->process_event_buffer(it_begin, it_end); });
}

template<typename EventIt>
void PeriodicHistoFrameGenerationAlgorithm::process_event_buffer(EventIt it_begin, EventIt it_end) {
    if (std::distance(it_begin, it_end) == 0)
        return;

    if (std::prev(it_end)->t < min_event_ts_us_to_use_)
        return; // No event to process

    if (it_begin->t < min_event_ts_us_to_use_) {
        // Time slice begins is in the middle of the input events
        it_begin = std::lower_bound(it_begin, it_end, min_event_ts_us_to_use_,

                                    [](const auto &ev, const timestamp ts) { return ev.t < ts; });
    }

    // // Add events in the time surface

    // // Checks time overflow. If one occurs, updates the time offset to apply and the timesurface accordingly.
    // while (std::prev(it_end)->t > ts_offset_ + std::numeric_limits<int32_t>::max()) {
    //     ts_offset_ += std::numeric_limits<int32_t>::max();
    //     for (auto &pix_data : time_surface_) {
    //         pix_data.first =
    //             pix_data.first >= std::numeric_limits<int32_t>::min() + std::numeric_limits<int32_t>::max() ?
    //                 pix_data.first - std::numeric_limits<int32_t>::max() :
    //                 std::numeric_limits<int32_t>::min();
    //     }
    // }

    // // Refresh the time-surface using the event buffer
    // for (auto it = it_begin; it != it_end; ++it) {
    //     const int32_t it_t                    = static_cast<int32_t>(it->t - ts_offset_);
    //     time_surface_[it->y * width_ + it->x] = {it_t, it->p};
    // }
    frame_unpacked_.reset();
    const auto &cfg = frame_unpacked_.get_config();
    auto &histo     = frame_unpacked_.get_data();
    for (auto it = it_begin; it != it_end; ++it) {
        const unsigned int idx = it->p + (it->x + it->y * cfg.width) * 2;
        const uint8_t sum_max  = (it->p == 0 ? sum_max_neg_ : sum_max_pos_);
        uint8_t &sum_events    = histo[idx];
        if (sum_events <= sum_max - 1) {
            ++sum_events;
        } else { // sum_events is saturated
        }
    }

}

} // namespace Metavision

#endif // METAVISION_SDK_CORE_PERIODIC_FRAME_GENERATION_ALGORITHM_H