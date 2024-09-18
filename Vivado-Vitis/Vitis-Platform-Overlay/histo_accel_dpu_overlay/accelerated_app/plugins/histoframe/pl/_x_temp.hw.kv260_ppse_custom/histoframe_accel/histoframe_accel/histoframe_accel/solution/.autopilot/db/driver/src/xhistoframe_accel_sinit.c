// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xhistoframe_accel.h"

extern XHistoframe_accel_Config XHistoframe_accel_ConfigTable[];

XHistoframe_accel_Config *XHistoframe_accel_LookupConfig(u16 DeviceId) {
	XHistoframe_accel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XHISTOFRAME_ACCEL_NUM_INSTANCES; Index++) {
		if (XHistoframe_accel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XHistoframe_accel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XHistoframe_accel_Initialize(XHistoframe_accel *InstancePtr, u16 DeviceId) {
	XHistoframe_accel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XHistoframe_accel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XHistoframe_accel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

