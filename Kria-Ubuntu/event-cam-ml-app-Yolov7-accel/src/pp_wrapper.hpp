/*
 * Copyright 2019 Xilinx Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <sys/time.h>
#include <iostream>
#include <vector>
#include <numeric>
#include <chrono>
#include <filesystem>
#include <dirent.h>
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"
#include "xrt/xrt_bo.h"


typedef struct AcceleratorHandle_t
{
	xrt::kernel kernel;
	xrt::device device;
	xrt::run runner;
	xrt::bo input;	
	xrt::bo output;	
	void *input_m;
	void *output_m;	
} AcceleratorHandle;

static std::vector<std::string> get_xclbins_in_dir(std::string path)
{
	if (path.find(".xclbin") != std::string::npos)
		return {path};

	std::vector<std::string> xclbinPaths;

	DIR *dir;
	struct dirent *ent;
	if ((dir = opendir(path.c_str())) != NULL)
	{
		/* print all the files and directories within directory */
		while ((ent = readdir(dir)) != NULL)
		{
			std::string name(ent->d_name);
			if (name.find(".xclbin") != std::string::npos)
				xclbinPaths.push_back(path + "/" + name);
		}
		closedir(dir);
	}
	return xclbinPaths;
}

int cd_frame_accel(AcceleratorHandle *accelerator, unsigned char *in_image_data,
		int img_ht, int img_wt, int out_ht, int out_wt, int8_t *dpu_input_buf_addr,int no_zcpy)
{

	// Input size to transfer
	const int imageToDevice_size = img_wt * img_ht  * sizeof(char);

	// Copy to input BO
	std::memcpy(accelerator->input_m, in_image_data, imageToDevice_size);

	// Send the input imageToDevice data to the device memory
	accelerator->input.sync(xclBOSyncDirection::XCL_BO_SYNC_BO_TO_DEVICE, imageToDevice_size, 0);


	// Invoke accelerator
	if (!no_zcpy)
		accelerator->runner(accelerator->input, accelerator->output, img_ht,img_wt, out_wt,out_ht);
	else
		accelerator->runner(accelerator->input,accelerator->output,img_ht,img_wt, out_wt,out_ht);
	//// Wait for execution to finish
	accelerator->runner.wait();

	if (no_zcpy)
	{
		// Copy the output data from device to host memory
		const int output_size = out_ht * out_wt * 3*sizeof(char);
		accelerator->output.sync(xclBOSyncDirection::XCL_BO_SYNC_BO_FROM_DEVICE);
		// Copy to output buffer
		int8_t *out_data = (int8_t *)dpu_input_buf_addr;
		std::memcpy(out_data,accelerator->output_m, output_size);      
	}   

	return 0;
}

AcceleratorHandle * pp_kernel_init(int out_ht, int out_wt, int no_zcpy)
{
	// get xclbin dir path and acquire handle
	const char *xclbinPath = std::getenv("XLNX_VART_FIRMWARE");

	if (xclbinPath == nullptr)
		throw std::runtime_error("Error: xclbinPath is not set, please consider setting XLNX_VART_FIRMWARE.");

	// get available xclbins
	auto xclbins = get_xclbins_in_dir(xclbinPath);
	const char *xclbin = xclbins[0].c_str();

	// Device/Card Index on system
	unsigned device_index = 0;

	// Check for devices on the system
	if (device_index >= xclProbe())
	{
		throw std::runtime_error("Cannot find device index specified");
		return nullptr;
	} 

	// Acquire Device by index
	auto device = xrt::device(device_index);    
	// Load XCLBIN
	auto uuid = device.load_xclbin(xclbin);    
	// Get Kernel/Pre-Proc CU
	auto preproc_accelerator = xrt::kernel(device, uuid, "histoframe_accel:{histoframe_accel_1}");

	// Get runner instance from xrt
	auto runner = xrt::run(preproc_accelerator);
	// Create BO for input/output/params

	auto input_mem_grp = preproc_accelerator.group_id(0);	
	auto output_mem_grp = preproc_accelerator.group_id(1);
	
	// Creating memory for 4K image
	const int in_image_size = 1280 *720 * 2 * sizeof(char);

	auto input = xrt::bo(device, in_image_size, input_mem_grp);
	void *input_m = input.map();
	if (input_m == nullptr)
		throw std::runtime_error("[ERRR] Input pointer is invalid\n");      

	
	// Return accelerator handle
	auto accel_handle = new AcceleratorHandle();

	if (no_zcpy)
	{
		// Create memory for output image
		const int out_image_size = out_ht * out_wt * 3* sizeof(char);
		auto output = xrt::bo(device, out_image_size, output_mem_grp);
		void *output_m = output.map();

		if (output_m == nullptr)
			throw std::runtime_error("[ERRR] Output pointer is invalid\n");

		accel_handle->output = std::move(output);
		accel_handle->output_m = output_m;
	}


	accel_handle->kernel = std::move(preproc_accelerator);
	accel_handle->device = std::move(device);
	accel_handle->runner = std::move(runner);
	accel_handle->input = std::move(input);  	
	accel_handle->input_m = input_m; 	

	// Return accelerator handle
	return accel_handle;
}
