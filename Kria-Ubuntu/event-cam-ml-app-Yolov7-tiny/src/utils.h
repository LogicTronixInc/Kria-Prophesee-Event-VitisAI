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
const int classificationCnt =2;
const int anchorCnt = 3;

typedef struct {
  int w;
  int h;
  int c;
  float* data;
} image;

image load_image_cv(const cv::Mat& img);
image letterbox_image(image im, int w, int h);
void free_image(image m);

inline float sigmoid(float p) { return 1.0 / (1 + exp(-p * 1.0)); }

inline float overlap(float x1, float w1, float x2, float w2) {
  float left = max(x1 - w1 / 2.0, x2 - w2 / 2.0);
  float right = min(x1 + w1 / 2.0, x2 + w2 / 2.0);
  return right - left;
}

inline float cal_iou(vector<float> box, vector<float> truth) {
  float w = overlap(box[0], box[2], truth[0], truth[2]);
  float h = overlap(box[1], box[3], truth[1], truth[3]);
  if (w < 0 || h < 0) return 0;

  float inter_area = w * h;
  float union_area = box[2] * box[3] + truth[2] * truth[3] - inter_area;
  return inter_area * 1.0 / union_area;
}

void correct_region_boxes(vector<vector<float>>& boxes, int n, int w, int h,
                          int netw, int neth, int relative = 0) {
  int new_w = 0;
  int new_h = 0;

  if (((float)netw / w) < ((float)neth / h)) {
    new_w = netw;
    new_h = (h * netw) / w;
  } else {
    new_h = neth;
    new_w = (w * neth) / h;
  }
  for (int i = 0; i < n; ++i) {
    boxes[i][0] = (boxes[i][0] - (netw - new_w) / 2. / netw) /
                  ((float)new_w / (float)netw);
    boxes[i][1] = (boxes[i][1] - (neth - new_h) / 2. / neth) /
                  ((float)new_h / (float)neth);
    boxes[i][2] *= (float)netw / new_w;
    boxes[i][3] *= (float)neth / new_h;
  }
}

void detect(vector<vector<float>>& boxes, vector<float> result, int channel,
            int height, int weight, int num, int sh, int sw,float scale,float conf);

void detect(vector<vector<float>>& boxes, vector<float> result, int channel,
            int height, int width, int num, int sHeight, int sWidth,float scale,float conf) {
  //  vector<float> biases{10,13,16,30,33,23,30,61,62,45,59,119,116,90,156,198,373,326};
  vector<float> biases{12,16, 19,36, 40,28,36,75, 76,55, 72,146,142,110, 192,243, 459,401};
  //vector<float> biases{36,75, 76,55, 72,146,12,16, 19,36, 40,28,142,110, 192,243, 459,401};
  //vector<float> biases{142,110, 192,243, 459,401,12,16, 19,36, 40,28,36,75, 76,55, 72,146};

 
//  vector<float> biases{13,18,19,26,28,40,43,39,53,63,83,104};
  // vector<float> biases{41, 42, 55, 59, 84, 79, 101, 100, 155, 145, 244, 239};
  
 int conf_box = 5 + classificationCnt;
 int index = 0;
 auto conf_desigmoid = -logf(1.0f / conf - 1.0f);
  float* swap_data = new float[channel * height * width];

  for (int h = 0; h < height; ++h) {
    for (int w = 0; w < width; ++w) {
      for (int c = 0; c < channel; ++c) {
        int temp = c * height * width + h * width + w;
        swap_data[index++] = result[c * height * width + h * width + w];
      }
    }
  }
  for (int h = 0; h < height; ++h) {
    for (int w = 0; w < width; ++w) {
      for (int c = 0; c < anchorCnt; ++c) {
        //float obj_score = sigmoid(swap[h * width + w][c][4]);
	int idx = ((h * width + w) * anchorCnt + c) * conf_box;
	if (swap_data[idx + 4] * scale < conf_desigmoid) continue;
        vector<float> box;        
	//if (obj_score < CONF) continue;
        //vector<float> box;
 	     float obj_score = sigmoid(swap_data[idx + 4] * scale);

        box.push_back((w + sigmoid(swap_data[idx] * scale)) / width);
        box.push_back((h + sigmoid(swap_data[idx + 1] * scale)) / height);
        box.push_back(exp(swap_data[idx + 2] * scale) *
                      biases[2 * c + 2 * anchorCnt * num] / float(sWidth));
        box.push_back(exp(swap_data[idx + 3] * scale) *
                      biases[2 * c + 2 *anchorCnt * num + 1] /
                      float(sHeight));
        box.push_back(-1);
        box.push_back(obj_score);
        for (int p = 0; p < classificationCnt; p++) {
          box.push_back(obj_score * sigmoid(swap_data[idx + 5 + p] * scale));
        }
        boxes.push_back(box);
      }
    }
  }
 delete[] swap_data;
}






vector<vector<float>> applyNMS(vector<vector<float>>& boxes, int classes,
                               const float thres,float conf) {
  vector<pair<int, float>> order(boxes.size());
  vector<vector<float>> result;

  for (int k = 0; k < classes; k++) {
    for (size_t i = 0; i < boxes.size(); ++i) {
      order[i].first = i;
      boxes[i][4] = k;
      order[i].second = boxes[i][6 + k];
    }
    sort(order.begin(), order.end(),
         [](const pair<int, float>& ls, const pair<int, float>& rs) {
           return ls.second > rs.second;
         });

    vector<bool> exist_box(boxes.size(), true);

    for (size_t _i = 0; _i < boxes.size(); ++_i) {
      size_t i = order[_i].first;
      if (!exist_box[i]) continue;
      if (boxes[i][6 + k] < conf) {
        exist_box[i] = false;
        continue;
      }
      /* add a box as result */
      result.push_back(boxes[i]);

      for (size_t _j = _i + 1; _j < boxes.size(); ++_j) {
        size_t j = order[_j].first;
        if (!exist_box[j]) continue;
        float ovr = cal_iou(boxes[j], boxes[i]);
        if (ovr >= thres) exist_box[j] = false;
      }
    }
  }

  return result;
}

void get_output(int8_t* dpuOut, int sizeOut, int oc, int oh, int ow,
                float output_scale, vector<float>& result) {
  // vector<int8_t> nums(sizeOut);
  // memcpy(nums.data(), dpuOut, sizeOut);
  for (int a = 0; a < oc; ++a) {
    for (int b = 0; b < oh; ++b) {
      for (int c = 0; c < ow; ++c) {
        int offset = b * oc * ow + c * oc + a;
        result[a * oh * ow + b * ow + c] = dpuOut[offset] * output_scale;
      }
    }
  }
}

static float get_pixel(image m, int x, int y, int c) {
  assert(x < m.w && y < m.h && c < m.c);
  return m.data[c * m.h * m.w + y * m.w + x];
}

static void set_pixel(image m, int x, int y, int c, float val) {
  if (x < 0 || y < 0 || c < 0 || x >= m.w || y >= m.h || c >= m.c) return;
  assert(x < m.w && y < m.h && c < m.c);
  m.data[c * m.h * m.w + y * m.w + x] = val;
}

static void add_pixel(image m, int x, int y, int c, float val) {
  assert(x < m.w && y < m.h && c < m.c);
  m.data[c * m.h * m.w + y * m.w + x] += val;
}

image make_empty_image(int w, int h, int c) {
  image out;
  out.data = 0;
  out.h = h;
  out.w = w;
  out.c = c;
  return out;
}

void free_image(image m) {
  if (m.data) {
    free(m.data);
  }
}

image make_image(int w, int h, int c) {
  image out = make_empty_image(w, h, c);
  out.data = (float*)calloc(h * w * c, sizeof(float));
  return out;
}

void fill_image(image m, float s) {
  int i;
  for (i = 0; i < m.h * m.w * m.c; ++i) m.data[i] = s;
}

void embed_image(image source, image dest, int dx, int dy) {
  int x, y, k;
  for (k = 0; k < source.c; ++k) {
    for (y = 0; y < source.h; ++y) {
      for (x = 0; x < source.w; ++x) {
        float val = get_pixel(source, x, y, k);
        set_pixel(dest, dx + x, dy + y, k, val);
      }
    }
  }
}

void rgbgr_image(image im) {
  int i;
  for (i = 0; i < im.w * im.h; ++i) {
    float swap = im.data[i];
    im.data[i] = im.data[i + im.w * im.h * 2];
    im.data[i + im.w * im.h * 2] = swap;
  }
}

image resize_image(image im, int w, int h) {
  image resized = make_image(w, h, im.c);
  image part = make_image(w, im.h, im.c);
  int r, c, k;
  float w_scale = (float)(im.w - 1) / (w - 1);
  float h_scale = (float)(im.h - 1) / (h - 1);
  for (k = 0; k < im.c; ++k) {
    for (r = 0; r < im.h; ++r) {
      for (c = 0; c < w; ++c) {
        float val = 0;
        if (c == w - 1 || im.w == 1) {
          val = get_pixel(im, im.w - 1, r, k);
        } else {
          float sx = c * w_scale;
          int ix = (int)sx;
          float dx = sx - ix;
          val = (1 - dx) * get_pixel(im, ix, r, k) +
                dx * get_pixel(im, ix + 1, r, k);
        }
        set_pixel(part, c, r, k, val);
      }
    }
  }
  for (k = 0; k < im.c; ++k) {
    for (r = 0; r < h; ++r) {
      float sy = r * h_scale;
      int iy = (int)sy;
      float dy = sy - iy;
      for (c = 0; c < w; ++c) {
        float val = (1 - dy) * get_pixel(part, c, iy, k);
        set_pixel(resized, c, r, k, val);
      }
      if (r == h - 1 || im.h == 1) continue;
      for (c = 0; c < w; ++c) {
        float val = dy * get_pixel(part, c, iy + 1, k);
        add_pixel(resized, c, r, k, val);
      }
    }
  }

  free_image(part);
  return resized;
}

image load_image_cv(const cv::Mat& img) {
  int h = img.rows;
  int w = img.cols;
  int c = img.channels();
  image im = make_image(w, h, c);

  unsigned char* data = img.data;

  for (int i = 0; i < h; ++i) {
    for (int k = 0; k < c; ++k) {
      for (int j = 0; j < w; ++j) {
        im.data[k * w * h + i * w + j] = data[i * w * c + j * c + k] / 256.;
      }
    }
  }

  for (int i = 0; i < im.w * im.h; ++i) {
    float swap = im.data[i];
    im.data[i] = im.data[i + im.w * im.h * 2];
    im.data[i + im.w * im.h * 2] = swap;
  }

  return im;
}

image letterbox_image(image im, int w, int h) {
  int new_w = im.w;
  int new_h = im.h;
  if (((float)w / im.w) < ((float)h / im.h)) {
    new_w = w;
    new_h = (im.h * w) / im.w;
  } else {
    new_h = h;
    new_w = (im.w * h) / im.h;
  }
  image resized = resize_image(im, new_w, new_h);
  image boxed = make_image(w, h, im.c);
  fill_image(boxed, .5);

  embed_image(resized, boxed, (w - new_w) / 2, (h - new_h) / 2);
  free_image(resized);

  return boxed;
}
