#include <chrono>

#include <metavision/sdk/driver/camera.h>
#include <metavision/sdk/base/events/event_cd.h>
#include "periodic_histo_frame_generation_algorithm.h"
#include "metavision/sdk/base/utils/timestamp.h"
#include <opencv2/opencv.hpp>

// this function will be associated to the camera callback
void count_events(const Metavision::EventCD *begin, const Metavision::EventCD *end) {
    int counter = 0;

    // this loop allows us to get access to each event received in this callback
    for (const Metavision::EventCD *ev = begin; ev != end; ++ev) {
        ++counter; // count each event

        // print each event
        std::cout << "Event received: coordinates (" << ev->x << ", " << ev->y << "), t: " << ev->t
                  << ", polarity: " << ev->p << std::endl;
    }

    // report
    std::cout << "There were " << counter << " events in this callback" << std::endl;
}

// main loop
int main(int argc, char *argv[]) {
    Metavision::Camera cam; // create the camera

    if (argc >= 2) {
        // if we passed a file path, open it
        cam = Metavision::Camera::from_file(argv[1]);
    } else {
        // open the first available camera
        cam = Metavision::Camera::from_first_available();
    }

    // to analyze the events, we add a callback that will be called periodically to give access to the latest events
    //cam.cd().add_callback(count_events);

    // to visualize the events, we will need to build frames and render them.
    // building frame will be done with a frame generator that will accumulate the events over time.
    // we need to provide it the camera resolution that we can retrieve from the camera instance
    int camera_width  = cam.geometry().width();
    int camera_height = cam.geometry().height();
    const int npixels       = camera_width * camera_height;

    bool enable_histo, enable_diff, diff_allow_rollover, histo_packed=0, disable_display;
    unsigned int histo_bit_size_neg = 4, histo_bit_size_pos=4, diff_bit_size=8;
    int nevents = -1;

    Metavision::timestamp period_us = 10000, min_generation_period_us = 0;


    // we also need to choose an accumulation time and a frame rate (here of 20ms and 50 fps)
    const std::uint32_t acc = 50000;
    double fps              = 20;

    auto histo_unpacked_chans_to_viz_fct = [&](uint8_t histo_val_neg, uint8_t histo_val_pos) {
        const uchar viz_val_neg = cv::saturate_cast<uchar>(histo_val_neg);
        const uchar viz_val_pos = cv::saturate_cast<uchar>(histo_val_pos);
        return cv::Vec3b(histo_val_neg, 0, histo_val_pos);
    };

// Instantiate visualization frames, display window and video writer
    const int visu_width  = camera_width ;
    const int visu_height = camera_height;
    cv::Mat visu_histo, combined_frame(visu_height, visu_width, CV_8UC3);
    visu_histo = combined_frame(cv::Rect(0, 0, camera_width, camera_height));
    char file_name[100];
    Metavision::RawEventFrameHisto histo_frame;
    std::mutex cd_frame_mutex;



    // now we can create our frame generator using previous variables
    auto frame_gen = Metavision::PeriodicHistoFrameGenerationAlgorithm(camera_width, camera_height, acc, fps, 
                                                                      camera_width, camera_height,
                                                                      histo_bit_size_neg, histo_bit_size_pos, histo_packed,
                                                                       min_generation_period_us);

    // we set a callback on the frame generator so that it calls the window object to display the generated frames
    // frame_gen.set_output_callback([&](Metavision::timestamp, cv::Mat &frame) { std::cout << "callback from histo frame generator\n";});
    // frame_gen.set_output_callback([&](Metavision::timestamp ts, Metavision::RawEventFrameHisto &evframe_histo) { 
     frame_gen.set_output_callback([&](Metavision::timestamp, cv::Mat &frame) {    
        std::unique_lock<std::mutex> lock(cd_frame_mutex);
        
        // Get the current time from the system clock
        auto now = std::chrono::system_clock::now();

        // Convert the current time to time since epoch
        auto duration = now.time_since_epoch();

        // Convert duration to milliseconds
        auto milliseconds
            = std::chrono::duration_cast<std::chrono::milliseconds>(
                duration)
                .count();

        // Print the result
        std::cout << "Current time in milliseconds is: "
            << milliseconds << std::endl;
        
        std::cout << "callback from histo frame generator\n";
        // const bool histo_generated = frame_gen.generate(ts, histo_frame);
        // if (histo_generated) {
        //     // std::cout << "histo frame generated\n";
        //     for (int y = 0; y < camera_height; ++y) {
        //         // auto it_histo_line_neg = evframe_histo.get_data().cbegin() + y * camera_width * 2;
        //         // auto it_histo_line_pos = evframe_histo.get_data().cbegin() + y * camera_width * 2 + 1;
        //         auto it_histo_line_neg = histo_frame.get_data().cbegin() + y * camera_width * 2;
        //         auto it_histo_line_pos = histo_frame.get_data().cbegin() + y * camera_width * 2 + 1;
        //         for (int i = 0; i < camera_width; ++i) {
        //             visu_histo.ptr<cv::Vec3b>(y)[i] =
        //                 histo_unpacked_chans_to_viz_fct(it_histo_line_neg[2 * i], it_histo_line_pos[2 * i]);
        //             // std::cout << "[ " << static_cast<unsigned>(it_histo_line_neg[2 * i]) << ", " << static_cast<unsigned>(it_histo_line_pos[2 * i]) << " ]";

        //         }
        //         // std::cout << std::endl;
        //     }

            sprintf(file_name, "histo_frame_combined%ld.png", milliseconds);
            cv::imwrite(file_name, frame);
        // }

        
        
    });


    // we add the callback that will pass the events to the frame generator
    cam.cd().add_callback([&](const Metavision::EventCD *begin, const Metavision::EventCD *end) {
        frame_gen.process_events(begin, end);
    });


    // start the camera
    cam.start();

    // keep running while the camera is on or the recording is not finished
    while (cam.is_running()) {}

    // the recording is finished, stop the camera.
    // Note: we will never get here with a live camera
    cam.stop();
}
