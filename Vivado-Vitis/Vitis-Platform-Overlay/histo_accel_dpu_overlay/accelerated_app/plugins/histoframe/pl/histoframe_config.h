/*
* Author: Nikil Thapa
*/

#ifndef _XF_HISTOFRAME_CONFIG_
#define _XF_HISTOFRAME_CONFIG_

//#include "hls_stream.h"
//#include "ap_int.h"
//#include "./common/xf_common.hpp"
//#include "./common/xf_utility.hpp"

#include "common/xf_common.hpp"
#include "common/xf_utility.hpp"
//#include "dnn/xf_preprocess.hpp"
//#include "dnn/xf_letterbox.hpp"
//#include "imgproc/xf_crop.hpp"
//#include "imgproc/xf_cvt_color.hpp"
//#include "imgproc/xf_cvt_color_1.hpp"
//#include "imgproc/xf_duplicateimage.hpp"
//#include "imgproc/xf_resize.hpp"
//#include "xf_config_params.h"
#include <ap_int.h>
#include <hls_stream.h>



#define INPUT_PTR_WIDTH 128
#define OUTPUT_PTR_WIDTH 128

#define WIDTH 2560
#define HEIGHT 720

#define OUT_WIDTH 1280
#define OUT_HEIGHT 720

#define XF_CV_DEPTH_IN 2
#define XF_CV_DEPTH_OUT 2

#define NPPCX XF_NPPC1

#define IN_TYPE XF_8UC1
#define OUT_TYPE XF_8UC3

#define CV_IN_TYPE CV_8UC1
#define CV_OUT_TYPE CV_8UC3

#define _XF_SYNTHESIS_ 1

#endif

//void histoframe_accel(ap_uint<INPUT_PTR_WIDTH> *dat_inp,ap_uint<OUTPUT_PTR_WIDTH> *dat_out, int rows_in, int cols_in, int out_height,int out_width);
		

