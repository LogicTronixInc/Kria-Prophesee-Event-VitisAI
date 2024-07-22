/*
 * Copyright 2019 Xilinx Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
  The following source code derives from Darknet
*/

#include <math.h>

#include <algorithm>
#include <iomanip>
#include <iosfwd>
#include <memory>
#include <opencv2/opencv.hpp>
#include <string>
#include <utility>
#include <vector>

using namespace std;
using namespace std::chrono;

// #define CONF 0.3
const int classificationCnt = 2;
const int anchorCnt = 3;

typedef struct
{
  int w;
  int h;
  int c;
  float *data;
} image;

inline float sigmoid(float p) { return 1.0 / (1 + exp(-p * 1.0)); }

inline float overlap(float x1, float w1, float x2, float w2)
{
  float left = max(x1 - w1 / 2.0, x2 - w2 / 2.0);
  float right = min(x1 + w1 / 2.0, x2 + w2 / 2.0);
  return right - left;
}

inline float cal_iou(vector<float> box, vector<float> truth)
{
  float w = overlap(box[0], box[2], truth[0], truth[2]);
  float h = overlap(box[1], box[3], truth[1], truth[3]);
  if (w < 0 || h < 0)
    return 0;

  float inter_area = w * h;
  float union_area = box[2] * box[3] + truth[2] * truth[3] - inter_area;
  return inter_area * 1.0 / union_area;
}

void correct_region_boxes(vector<vector<float>> &boxes, int n, int w,
                          int h, int netw, int neth)
{
  int new_w = 0;
  int new_h = 0;

  if (((float)netw / w) < ((float)neth / h))
  {
    new_w = netw;
    new_h = (h * netw) / w;
  }
  else
  {
    new_h = neth;
    new_w = (w * neth) / h;
  }
  for (int i = 0; i < n; ++i)
  {
    boxes[i][0] = (boxes[i][0] - (netw - new_w) / 2. / netw) /
                  ((float)new_w / (float)netw);
    boxes[i][1] = (boxes[i][1] - (neth - new_h) / 2. / neth) /
                  ((float)new_h / (float)neth);
    boxes[i][2] *= (float)netw / new_w;
    boxes[i][3] *= (float)neth / new_h;
  }
}

void applyNMS_new(const vector<vector<float>> &boxes,
                  const vector<float> &scores, const float nms,
                  const float conf, vector<size_t> &res)
{
  const size_t count = boxes.size();
  vector<pair<float, size_t>> order;
  for (size_t i = 0; i < count; ++i)
  {
    order.push_back({scores[i], i});
  }
  stable_sort(order.begin(), order.end(),
              [](const pair<float, size_t> &ls, const pair<float, size_t> &rs)
              {
                return ls.first > rs.first;
              });
  vector<size_t> ordered;
  transform(order.begin(), order.end(), back_inserter(ordered),
            [](auto &km)
            { return km.second; });
  vector<bool> exist_box(count, true);

  for (size_t _i = 0; _i < count; ++_i)
  {
    size_t i = ordered[_i];
    if (!exist_box[i])
      continue;
    if (scores[i] < conf)
    {
      exist_box[i] = false;
      continue;
    }
    /* add a box as result */
    res.push_back(i);
    // cout << "nms push "<< i<<endl;
    for (size_t _j = _i + 1; _j < count; ++_j)
    {
      size_t j = ordered[_j];
      if (!exist_box[j])
        continue;
      float ovr = 0.0;
      ovr = cal_iou(boxes[j], boxes[i]);
      if (ovr >= nms)
        exist_box[j] = false;
    }
  }
}

void get_output(int8_t *dpuOut, int sizeOut, int oc, int oh, int ow,
                float output_scale, vector<float> &result)
{
  // vector<int8_t> nums(sizeOut);
  // memcpy(nums.data(), dpuOut, sizeOut);
  for (int a = 0; a < oc; ++a)
  {
    for (int b = 0; b < oh; ++b)
    {
      for (int c = 0; c < ow; ++c)
      {
        int offset = b * oc * ow + c * oc + a;
        result[a * oh * ow + b * ow + c] = dpuOut[offset] * output_scale;
      }
    }
  }
}

void detect_new(vector<vector<float>> &boxes, int8_t *det_out, int channel,
                int height, int width, int num, int sHeight, int sWidth, float det_scale, float conf)
{
  // int8_t* det_out = (int8_t*)outTensorList[num].get_data(0);
  // int8_t* det_out = result;
  vector<float> biases{10, 13, 16, 30, 33, 23, 30, 61, 62, 45, 59, 119, 116, 90, 156, 198, 373, 326};

  int8_t conf_thresh_inverse =
      -std::log(1.0f / conf - 1) / det_scale;

  for (int h = 0; h < height; ++h)
  {
    for (int w = 0; w < width; ++w)
    {
      for (auto cnt = 0; cnt < anchorCnt; cnt++)
      {

        int idx = channel * (h * width + w) + cnt * (classificationCnt + 5);
        if (det_out[idx + 4] > conf_thresh_inverse)
        {
          vector<float> box;
          float obj_score = sigmoid(det_out[idx + 4] * det_scale);
          box.push_back((sigmoid(det_out[idx] * det_scale) * 2 - 0.5 + w) /
                        width);
          box.push_back(
              (sigmoid(det_out[idx + 1] * det_scale) * 2 - 0.5 + h) /
              height);
          box.push_back(pow(sigmoid(det_out[idx + 2] * det_scale) * 2, 2) *
                        biases[2 * cnt + 2 * anchorCnt * num] /
                        (float)(sWidth));
          box.push_back(pow(sigmoid(det_out[idx + 3] * det_scale) * 2, 2) *
                        biases[2 * cnt + 2 * anchorCnt * num + 1] /
                        (float)(sHeight));
          box.push_back(-1);
          box.push_back(obj_score);
          for (int p = 0; p < classificationCnt; p++)
          {
            box.push_back(obj_score *
                          sigmoid(det_out[idx + 5 + p] * det_scale));
          }
          boxes.push_back(box);
        }
      }
    }
  }
}