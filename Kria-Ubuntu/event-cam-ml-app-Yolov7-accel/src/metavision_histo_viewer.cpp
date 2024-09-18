/**********************************************************************************************************************
 * Copyright (c) Prophesee S.A.                                                                                       *
 *                                                                                                                    *
 * Licensed under the Apache License, Version 2.0 (the "License");                                                    *
 * you may not use this file except in compliance with the License.                                                   *
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0                                 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed   *
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                      *
 * See the License for the specific language governing permissions and limitations under the License.                 *
 **********************************************************************************************************************/

// Example of using Metavision SDK Driver API for visualizing events stream, setting ROI and ERC as well as
// saving and loading the camera settings to and from camera settings files

#include <atomic>
#include <chrono>
#include <iomanip>
#include <signal.h>
#include <thread>
#include <boost/program_options.hpp>
#include <opencv2/highgui/highgui.hpp>
#if CV_MAJOR_VERSION >= 4
#include <opencv2/highgui/highgui_c.h>
#endif
#include <opencv2/imgproc.hpp>
#include <metavision/sdk/base/utils/log.h>
#include <metavision/sdk/core/utils/misc.h>
#include <metavision/sdk/core/utils/rate_estimator.h>
#include <metavision/sdk/driver/camera.h>
#include <metavision/sdk/driver/camera_error_code.h>
#include <metavision/hal/facilities/i_plugin_software_info.h>

#include "cd_histo_frame_generator.h"

/*******************************ML functions***********************/
#include "common.h"
#include "utils.h"
#include <thread>
#include <queue>
#include <mutex>

using namespace std;
using namespace cv;
using namespace std::chrono;

#define NMS_THRESHOLD 0.1f

int idxInputImage = 0; // frame index of input video
int idxShowImage = 0;  // next frame index to be displayed
bool bReading = true;  // flag of reding input frame
bool bExiting = false;
chrono::system_clock::time_point start_time;

typedef pair<int, Mat> imagePair;
class paircomp
{
public:
    bool operator()(const imagePair &n1, const imagePair &n2) const
    {
        if (n1.first == n2.first)
        {
            return (n1.first > n2.first);
        }

        return n1.first > n2.first;
    }
};


// mutex for protecFtion of display frmaes queue
mutex mtxQueueShow;
mutex mtxQueueShow_own;
mutex mtxQueueInput_own;
// input frames queue
queue<pair<int, Mat>> queueInput;
// display frames queue
priority_queue<imagePair, vector<imagePair>, paircomp> queueShow;
queue<Mat> queueShow_own;
queue<Mat> queueInput_own;

GraphInfo shapes;

/**
 * @brief Map histo frame vale to 0-1
 *
 * @param original_value - pointer to DPU Task for YOLO-v3 network
 *
 * @return float
 */



float map_to_0_1_with_step_size(float original_value)
{
    //float value[6] = {0, 0.2, 0.4, 0.6, 0.8, 1};
    float value[6] = {0,1.6062,3.2125,4.8188,6.425,8.03137};
    // # Calculate which segment the original_value falls into
    float segment_width = 0.8;
    // # This is the width of each segment in the input range
    // int segment_index = int(original_value) ;
    int segment_index = int(original_value / segment_width);
    // # Determine the segment index
    if (segment_index > 5)
        return 1;
    return value[segment_index];
}


/**
 * @brief Thread entry for displaying image frames
 *
 * @param  none
 * @return none
 *
 */
void displayFrame()
{
    Mat frame;

    while (true)
    {
        if (bExiting)
            break;
        mtxQueueShow_own.lock();

        if (queueShow_own.empty())
        {
            mtxQueueShow_own.unlock();
            usleep(10);
        }
        else 
        {
            auto show_time = chrono::system_clock::now();
            stringstream buffer;

            frame = queueShow_own.front(); // Get the item
            queueShow_own.pop(); // Remove 
            if (frame.rows <= 0 || frame.cols <= 0)
            {
                mtxQueueShow_own.unlock();
                continue;
            }
            
            cv::imshow("Display Frame thread", frame);           
            
            mtxQueueShow_own.unlock();
            if (waitKey(1) == 'q')
            {
                bReading = false;
                exit(-1);                
            }
        }

       
    }
}

/**
 * @brief Post process after the running of DPU for YOLO-v3 network
 *
 * @param task - pointer to DPU task for running YOLO-v3
 * @param frame
 * @param sWidth
 * @param sHeight
 *
 * @return none
 */
//

void postProcess(vart::Runner *runner, Mat &frame, vector<int8_t *> results,
                 int sWidth, int sHeight, const float *output_scale, float conf)
{
    const string classes[7] = {"person", "vehicle","bicycle","bus","motorcycle","truck","traini"};

    vector<vector<float>> boxes;
    // auto  outputTensors = runner->get_output_tensors();
    for (int ii = 0; ii < 3; ii++)
    {
        int width = shapes.outTensorList[ii].width;
        int height = shapes.outTensorList[ii].height;
        int channel = shapes.outTensorList[ii].channel;
        int sizeOut = channel * width * height;
        vector<float> result(sizeOut);
        boxes.reserve(sizeOut);

        /* Store every output node results */

        detect_new(boxes, results[ii], channel, height, width, ii, sHeight, sWidth, output_scale[ii], conf);
    }

    /* Restore the correct coordinate frame of the original image */

    correct_region_boxes(boxes, boxes.size(), 320, 320, sWidth,
                         sHeight);

    /* Apply the computation for NMS */

    vector<vector<float>> res;
    vector<float> scores(boxes.size());
    for (int k = 0; k < classificationCnt; k++)
    {
        transform(boxes.begin(), boxes.end(), scores.begin(), [k](auto &box)
                  {
      box[4] = k;
      return box[6 + k]; });
        vector<size_t> result_k;
        applyNMS_new(boxes, scores, NMS_THRESHOLD, conf, result_k);
        transform(result_k.begin(), result_k.end(), back_inserter(res),
                  [&boxes](auto &k)
                  { return boxes[k]; });
    }
    float h = frame.rows;
    float w = frame.cols;
    for (size_t i = 0; i < res.size(); ++i)
    {
        float xmin = (res[i][0] - res[i][2] / 2.0) * w + 1.0;
        float ymin = (res[i][1] - res[i][3] / 2.0) * h + 1.0;
        float xmax = (res[i][0] + res[i][2] / 2.0) * w + 1.0;
        float ymax = (res[i][1] + res[i][3] / 2.0) * h + 1.0;

        if (res[i][res[i][4] + 6] > conf)
        {
            int type = res[i][4];
            string classname = classes[type];
           
            if (type == 1)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(0, 0, 255), 1, 1, 0);
			 putText(frame, classname, cv::Point(xmin, ymin - 5), cv::FONT_HERSHEY_DUPLEX, 0.5, cv::Scalar(0, 255, 0), 0.2);			  
            }
            else if (type == 2)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(255, 0, 0), 1, 1, 0);
            }
            else if (type == 3)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(0, 0, 255), 1, 1, 0);
            }
            else if (type == 4)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(255, 0, 0), 1, 1, 0);
            }

            else if (type == 5)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(0, 0, 255), 1, 1, 0);
            }

            else if (type == 6)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(255, 0, 0), 1, 1, 0);
            }

            else if (type == 7)
            {
                rectangle(frame, Point(xmin, ymin), Point(xmax, ymax),
                          Scalar(0, 0, 255), 1, 1, 0);
            }

        }
    }
}

void runYOLO(vart::Runner *runner, float conf, float rmax, float bmax,int idxnum)
{
    /* mean values for YOLO-v3 */
    float mean[3] = {0.0001566, 0.00001234, 0.0};
    // string image_name = fileName;
    auto inputTensors = cloneTensorBuffer(runner->get_input_tensors());
    int width = shapes.inTensorList[0].width;
    int height = shapes.inTensorList[0].height;
    auto outputTensors = cloneTensorBuffer(runner->get_output_tensors());

    auto input_scale = get_input_scale(runner->get_input_tensors()[0]);
    auto output_scale = vector<float>();
    for (int i = 0; i < 3; i++)
    {
        output_scale.push_back(get_output_scale(
            runner->get_output_tensors()[shapes.output_mapping[i]]));
    }
    int8_t *data = new int8_t[shapes.inTensorList[0].size *
                              inputTensors[0]->get_shape().at(0)];
    //std::cout<<"shape of data is "<<shapes.inTensorList[0].size <<""<<inputTensors[0]->get_shape().at(0)<<std::endl;  
    int8_t *result0 =
        new int8_t[shapes.outTensorList[0].size *
                   outputTensors[shapes.output_mapping[0]]->get_shape().at(0)];
    int8_t *result1 =
        new int8_t[shapes.outTensorList[1].size *
                   outputTensors[shapes.output_mapping[1]]->get_shape().at(0)];
    int8_t *result2 =
        new int8_t[shapes.outTensorList[2].size *
                   outputTensors[shapes.output_mapping[2]]->get_shape().at(0)];

    vector<int8_t *> result;
    result.push_back(result0);
    result.push_back(result1);
    result.push_back(result2);
    // result.push_back(result3);
    std::vector<std::unique_ptr<vart::TensorBuffer>> inputs, outputs;
    std::vector<vart::TensorBuffer *> inputsPtr, outputsPtr;
   usleep(20000);
    while (true) {        
    Mat img;    
    mtxQueueInput_own.lock();
    if (queueInput_own.empty()) {
      mtxQueueInput_own.unlock();
      if (bExiting) break;
      if (bReading) {
        continue;
      } else {
        break;
      }
    } else {
      /* get an input frame from input frames queue */
      img = queueInput_own.front();
      queueInput_own.pop();
      mtxQueueInput_own.unlock();
    }

    Mat resized_down, combinedImage;
    cv::Mat image2ch(height, width, CV_8UC3);
    cv::Mat temp_image2ch(height, width, CV_8UC3);

    Mat image2 = cv::Mat(height, width, CV_8SC3);
    Mat image3 = cv::Mat(height, width, CV_8SC3);
    
    resize(img, image2, Size(width, height), 0, 0, INTER_LINEAR);

    int l = 0;
    for (int h = 0; h < height; h++)
    {
        for (int w = 0; w < width; w++)
        {
            for (int c = 0; c < 2; c++)
            {
                data[l] = (int8_t)(map_to_0_1_with_step_size(image2.at<Vec3b>(h, w)[c]));
                l++;
            }
        }
  
	}
    inputs.push_back(
        std::make_unique<CpuFlatTensorBuffer>(data, inputTensors[0].get()));

    outputs.push_back(std::make_unique<CpuFlatTensorBuffer>(
        result0, outputTensors[shapes.output_mapping[0]].get()));
    outputs.push_back(std::make_unique<CpuFlatTensorBuffer>(
        result1, outputTensors[shapes.output_mapping[1]].get()));
    outputs.push_back(std::make_unique<CpuFlatTensorBuffer>(
        result2, outputTensors[shapes.output_mapping[2]].get()));

    inputsPtr.push_back(inputs[0].get());
    outputsPtr.resize(3);
    outputsPtr[shapes.output_mapping[0]] = outputs[0].get();
    outputsPtr[shapes.output_mapping[1]] = outputs[1].get();
    outputsPtr[shapes.output_mapping[2]] = outputs[2].get();

    auto job_id = runner->execute_async(inputsPtr, outputsPtr);
    runner->wait(job_id.first, -1);
   
    postProcess(runner, img, result, width, height,
                output_scale.data(), conf);


    mtxQueueShow_own.lock();

  
   queueShow_own.push(img);
   mtxQueueShow_own.unlock();
    inputs.clear();
    outputs.clear();
    inputsPtr.clear();
    outputsPtr.clear();
  }
  delete[] data;
  delete[] result0;
  delete[] result1;
  delete[] result2;

}
//***************end of ML section****************************//

static const int ESCAPE = 27;
static const int SPACE = 32;

namespace po = boost::program_options;

int processUI(int delay_ms)
{
    auto then = std::chrono::high_resolution_clock::now();
    int key = cv::waitKey(delay_ms);
    auto now = std::chrono::high_resolution_clock::now();
    // cv::waitKey will not wait if no window is opened, so we wait for it, if needed
    std::this_thread::sleep_for(std::chrono::milliseconds(
        delay_ms - std::chrono::duration_cast<std::chrono::milliseconds>(now - then).count()));

    return key;
}

struct RoiControl
{
    bool use_windows; // Whether to set ROIs through windows or lines
    std::vector<bool> cols;
    std::vector<bool> rows;
    std::vector<Metavision::Roi::Window> windows;
    Metavision::I_ROI::Mode mode;
    cv::Point mouse_down_coord; // Coordinates of initial pixel while left mouse button is held down
    bool need_refresh;          // Whether ROIs need to be updated on the device
    const std::size_t max_windows;

    RoiControl(int width, int height, std::size_t max_supported_windows) : cols(width, 0), rows(height, 0), max_windows(max_supported_windows), mode(Metavision::I_ROI::Mode::ROI)
    {
        reset();
    }

    void reset()
    {
        std::fill(cols.begin(), cols.end(), false);
        std::fill(rows.begin(), rows.end(), false);
        windows.clear();
        mouse_down_coord.x = -1;
        need_refresh = false;
    }
};

void receiveMouseEvent(int event, int x, int y, int flags, void *userdata)
{
    RoiControl *roi_ctrl = reinterpret_cast<RoiControl *>(userdata);

    switch (event)
    {
    case cv::EVENT_LBUTTONDOWN:
        if (roi_ctrl->mouse_down_coord.x < 0)
        {
            roi_ctrl->mouse_down_coord.x = x;
            roi_ctrl->mouse_down_coord.y = y;
        }
        break;
    case cv::EVENT_LBUTTONUP:
        if (roi_ctrl->mouse_down_coord.x < 0)
        {
            break;
        }

        // Just a click from the user, ignore it
        if (roi_ctrl->mouse_down_coord.x == x && roi_ctrl->mouse_down_coord.y == y)
        {
            roi_ctrl->mouse_down_coord.x = -1;
            break;
        }

        {
            const int start_x = std::min(roi_ctrl->mouse_down_coord.x, x);
            const int end_x = std::max(roi_ctrl->mouse_down_coord.x, x);
            const int start_y = std::min(roi_ctrl->mouse_down_coord.y, y);
            const int end_y = std::max(roi_ctrl->mouse_down_coord.y, y);

            if (roi_ctrl->use_windows)
            {
                if (roi_ctrl->windows.size() >= roi_ctrl->max_windows)
                {
                    roi_ctrl->windows.clear();
                }
                roi_ctrl->windows.push_back({start_x, start_y, end_x - start_x + 1, end_y - start_y + 1});
            }
            else
            {
                for (int i = start_x; i <= end_x; ++i)
                {
                    roi_ctrl->cols[i] = true;
                }

                for (int i = start_y; i <= end_y; ++i)
                {
                    roi_ctrl->rows[i] = true;
                }
            }
            roi_ctrl->need_refresh = true;
        }

        roi_ctrl->mouse_down_coord.x = -1;
        break;
    default:
        break;
    }
}

namespace
{
    std::atomic<bool> signal_caught{false};

    [[maybe_unused]] void signalHandler(int s)
    {
        MV_LOG_TRACE() << "Interrupt signal received." << std::endl;
        signal_caught = true;
    }
} // anonymous namespace





int readFrameEvent(const char* fileName)
{
	 
	 
	 string event_file_path = fileName;
	 if (event_file_path == "0")
	 {
		event_file_path= "";
	 }
	 
    signal(SIGINT, signalHandler);
    std::atomic<bool> do_retry = false;

    const std::string short_program_desc(
        "Simple viewer to stream events from an event file or a device, using the SDK driver API.\n");
    std::string long_program_desc(short_program_desc +
                                  "Define a region using the cursor (click and drag) to set a Region of Interest (ROI)\n"
                                  "Press SPACE key while running to record or stop recording raw data\n"
                                  "Press 'q' or Escape key to leave the program.\n"
                                  "Press 'o' to toggle the on screen display.\n"
                                  "Press 'l' to load the camera settings from the input camera config file.\n"
                                  "Press 's' to save the camera settings to the output camera config file.\n"
                                  "Press 'r' to toggle the hardware ROI mode (window mode or lines mode, default: window mode).\n"
                                  "Press 'R' to toggle the ROI/RONI mode.\n"
                                  "Press 'e' to toggle the ERC module (if available).\n"
                                  "Press '+' to increase the ERC threshold (if available).\n"
                                  "Press '-' to decrease the ERC threshold (if available).\n"
                                  "Press 'h' to print this help.\n");

    po::options_description options_desc("Options");

    do
    {
        //std::cout<<"inside the do loop "<<std::endl;
        Metavision::Camera camera;
        bool camera_is_opened = false;

        // If the filename is set, then read from the file
        if (!event_file_path.empty())
        {

            try
            {
                Metavision::FileConfigHints hints;
                camera = Metavision::Camera::from_file(event_file_path, hints);
                camera_is_opened = true;
            }
            catch (Metavision::CameraException &e)
            {   //std::cout<<"error somewhere";
                bExiting = true;
                return -1;
                MV_LOG_ERROR() << e.what();
               
            }
            // Otherwise, set the input source to a camera
        }
         else
         {
          try
             {  
           camera = Metavision::Camera::from_first_available();
                 
                 camera_is_opened = true;
	     }
           catch (Metavision::CameraException &e)
	   {
		std::cout<<"cannot open cameraa"<<std::endl;
                 MV_LOG_ERROR() << e.what();
             }
         }


        if (!camera_is_opened)
        {   std::cout<<"camera is not opend "<<std::endl;
            if (do_retry)
            {
                std::this_thread::sleep_for(std::chrono::seconds(1));
                MV_LOG_INFO() << "Trying to reopen camera...";
                continue;
            }
            else
            {
                bExiting = true;
                return -1;
            }
        }
        else
        {
            MV_LOG_INFO() << "Camera has been opened successfully.";
        }

        // Add runtime error callback
        camera.add_runtime_error_callback([&do_retry](const Metavision::CameraException &e)
                                          {
            
            MV_LOG_ERROR() << e.what();
            do_retry = true; });

        char file_name[100];
        int frame_count = 0;

        // Get the geometry of the camera
        const auto &geometry = camera.geometry();

        // Setup CD event rate estimator
        double avg_rate, peak_rate;
        Metavision::RateEstimator cd_rate_estimator(
            [&avg_rate, &peak_rate](Metavision::timestamp ts, double arate, double prate)
            {
                avg_rate = arate;
                peak_rate = prate;
            },
            100000, 1000000, true);

        // Setup CD frame generator
        std::mutex cd_frame_generator_mutex;
        Metavision::CDHistoFrameGenerator cd_frame_generator(geometry.width(), geometry.height());
        cd_frame_generator.set_display_accumulation_time_us(10000);

        std::mutex cd_frame_mutex;
        cv::Mat cd_frame;
        Metavision::timestamp cd_frame_ts{0};
        cd_frame_generator.start(
            100, [&cd_frame_mutex, &cd_frame, &cd_frame_ts](const Metavision::timestamp &ts, const cv::Mat &frame)
            {
                std::unique_lock<std::mutex> lock(cd_frame_mutex);
                cd_frame_ts = ts;
                frame.copyTo(cd_frame); });

        unsigned int max_roi_windows = 0;
       
        int cd_events_cb_id =
            camera.cd().add_callback([&cd_frame_generator_mutex, &cd_frame_generator, &cd_rate_estimator](
                                         const Metavision::EventCD *ev_begin, const Metavision::EventCD *ev_end)
                                     {
                std::unique_lock<std::mutex> lock(cd_frame_generator_mutex);
                cd_frame_generator.add_events(ev_begin, ev_end);
                cd_rate_estimator.add_data(std::prev(ev_end)->t, std::distance(ev_begin, ev_end)); });

        // Start the camera streaming
        try
        {
            camera.start();
        }
        catch (const Metavision::CameraException &e)
        {
            MV_LOG_ERROR() << e.what();
            
        }

        bool recording = false;
        bool osc_available = false;
        bool osc_ready = false;
        bool osd = true;

        if (!event_file_path.empty())
        {
            try
            {
                camera.offline_streaming_control().is_ready();
                osc_available = true;
            }
            catch (Metavision::CameraException &e)
            {
                MV_LOG_ERROR() << e.what();
            }
        }
	    int frame_number = 0;

        while (!signal_caught && camera.is_running())
        {
            usleep(2000);
	    
            if (bReading){

            }
            if (!event_file_path.empty() && osc_available)
            {
                try
                {
                    osc_ready = camera.offline_streaming_control().is_ready();
                }
                catch (Metavision::CameraException &e)
                {
                    MV_LOG_ERROR() << e.what();
                }
            }


            {
                std::unique_lock<std::mutex> lock(cd_frame_mutex);
                if (!cd_frame.empty())
                {
		            frame_number++;
                    if (osd)
                    {
                        std::string text;
                        if (osc_ready)
                        {
                            text = Metavision::getHumanReadableTime(cd_frame_ts) + " / " +
                                   Metavision::getHumanReadableTime(camera.offline_streaming_control().get_duration());
                        }
                        else
                        {
                            text = Metavision::getHumanReadableTime(cd_frame_ts);
                        }
                        text += "     ";
                        text += Metavision::getHumanReadableRate(avg_rate);
                        cv::putText(cd_frame, text, cv::Point(10, 20), cv::FONT_HERSHEY_PLAIN, 1,
                                    cv::Scalar(108, 143, 255), 1, cv::LINE_AA);
                    }
                    auto cd_frame1 = cd_frame.clone();
                    if (queueInput_own.size() < 2) {
                        mtxQueueInput_own.lock();
                        queueInput_own.push(cd_frame1);
                        mtxQueueInput_own.unlock();
                    }
                    else {
                        usleep(2000);
                    }
                }
            }

	    }
        // unregister callbacks to make sure they are not called anymore
        if (cd_events_cb_id >= 0)
        {
            camera.cd().remove_callback(cd_events_cb_id);
        }

        // Stop the camera streaming, optional, the destructor will automatically do it
        try
        {
            camera.stop();
        }
        catch (const Metavision::CameraException &e)
        {
            MV_LOG_ERROR() << e.what();
        }
        cd_frame_generator.stop();
    } while (!signal_caught && do_retry);
    bExiting = true;
    return signal_caught;
}

int main(int argc, char *argv[])
{  
    auto graph = xir::Graph::deserialize(argv[1]);	
    auto subgraph = get_dpu_subgraph(graph.get());

    CHECK_EQ(subgraph.size(), 1u)
        << "yolov3 should have one and only one dpu subgraph.";
    LOG(INFO) << "create running for subgraph: " << subgraph[0]->get_name();

    auto runner = vart::Runner::create_runner(subgraph[0], "run");
    auto runner1 = vart::Runner::create_runner(subgraph[0], "run");
    auto runner2 = vart::Runner::create_runner(subgraph[0], "run");
    auto runner3 = vart::Runner::create_runner(subgraph[0], "run");
    auto runner4 = vart::Runner::create_runner(subgraph[0], "run");
    // get in/out tenosrs
    auto inputTensors = runner->get_input_tensors();
    auto outputTensors = runner->get_output_tensors();
    int inputCnt = inputTensors.size();
    int outputCnt = outputTensors.size();
    TensorShape inshapes[inputCnt];
    TensorShape outshapes[outputCnt];
    shapes.inTensorList = inshapes;
    shapes.outTensorList = outshapes;
    getTensorShape(runner.get(), &shapes, inputCnt, outputCnt);
    float conf = 0.3;
    float rmax = 3.1;
    float bmax = 4.2;
    array<thread, 4> threadsList = {
    thread(readFrameEvent, argv[2]),thread(displayFrame),
    thread(runYOLO, runner.get(), conf, rmax, bmax,1),thread(runYOLO, runner1.get(), conf, rmax, bmax,2)
    
    };

    for (int i = 0; i <4 ; i++)
    {
        threadsList[i].join();
    }

    return 0;
}
