/*
 * Author: Nikil Thapa
 *
 */

#include "histoframe_config.h"

static constexpr int __XF_DEPTH = (HEIGHT * WIDTH * (XF_PIXELWIDTH(IN_TYPE, NPPCX)) / 8) / (INPUT_PTR_WIDTH / 8);
static constexpr int __XF_DEPTH_OUT = (OUT_HEIGHT * OUT_WIDTH * (XF_PIXELWIDTH(IN_TYPE, NPPCX)) / 8) / (OUTPUT_PTR_WIDTH / 8);


	template <int TYPE_I, int TYPE_O, int SRC_ROWS, int SRC_COLS, int DST_ROWS,
			  int DST_COLS, int NPC, int XFCVDEPTH_IN, int XFCVDEPTH_OUT>
	void histoframe(
		xf::cv::Mat<TYPE_I, SRC_ROWS, SRC_COLS, NPC, XFCVDEPTH_IN> &_src,
		xf::cv::Mat<TYPE_O, DST_ROWS, DST_COLS, NPC, XFCVDEPTH_OUT> &_dst)
	{

		const int rows = _src.rows;
		const int cols = _src.cols;

		unsigned char d = 0;
		unsigned char o = 0;
		unsigned char e = 0;

		for (int i = 0; i < rows; i++)
		{
			for (int j = 0; j < cols; j++)
			{

				// clang-format off
#pragma HLS LOOP_TRIPCOUNT min=0 max=2560
#pragma HLS PIPELINE II=1
				// clang-format on

				d = _src.read(i).range(7, 0);

				if (j % 2 == 0)
					e = d * 17;
				else
					o = d * 17;

				if (j % 2 == 0)
				{

					_dst.write(j, (e << 16) + (o << 8) + 0);
				}
			}
		}
	}
	
extern "C"{
	void histoframe_accel(ap_uint<INPUT_PTR_WIDTH> *dat_inp,
						  ap_uint<OUTPUT_PTR_WIDTH> *dat_out, int rows_in, int cols_in,
						  int rows_out, int cols_out)
	{
		// clang-format off
#pragma HLS INTERFACE m_axi     port=dat_inp  offset=slave bundle=gmem1 depth=__XF_DEPTH
#pragma HLS INTERFACE m_axi     port=dat_out  offset=slave bundle=gmem2 depth=__XF_DEPTH_OUT
#pragma HLS INTERFACE s_axilite port=rows_in
#pragma HLS INTERFACE s_axilite port=cols_in
#pragma HLS INTERFACE s_axilite port=rows_out
#pragma HLS INTERFACE s_axilite port=cols_out
#pragma HLS INTERFACE s_axilite port=return
		// clang-format on

		xf::cv::Mat<IN_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_IN> in_mat(rows_in,
																		  cols_in);

		xf::cv::Mat<OUT_TYPE, OUT_HEIGHT, OUT_WIDTH, NPPCX, XF_CV_DEPTH_IN> out_mat(
			rows_out, cols_out);

		// clang-format off
#pragma HLS DATAFLOW
		// clang-format on
		
		
		

		xf::cv::Array2xfMat<INPUT_PTR_WIDTH, IN_TYPE, HEIGHT, WIDTH, NPPCX>(dat_inp, in_mat);

		histoframe<IN_TYPE, OUT_TYPE, HEIGHT, WIDTH, OUT_HEIGHT, OUT_WIDTH, NPPCX,
				   XF_CV_DEPTH_IN,
				   XF_CV_DEPTH_OUT>(in_mat, out_mat);

		xf::cv::xfMat2Array<OUTPUT_PTR_WIDTH, OUT_TYPE, OUT_HEIGHT, OUT_WIDTH,
							NPPCX>(out_mat, dat_out);
	}
}
/*
 * Author: Nikil Thapa
 *
 */
