// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XHISTOFRAME_ACCEL_H
#define XHISTOFRAME_ACCEL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xhistoframe_accel_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
} XHistoframe_accel_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XHistoframe_accel;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XHistoframe_accel_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XHistoframe_accel_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XHistoframe_accel_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XHistoframe_accel_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XHistoframe_accel_Initialize(XHistoframe_accel *InstancePtr, u16 DeviceId);
XHistoframe_accel_Config* XHistoframe_accel_LookupConfig(u16 DeviceId);
int XHistoframe_accel_CfgInitialize(XHistoframe_accel *InstancePtr, XHistoframe_accel_Config *ConfigPtr);
#else
int XHistoframe_accel_Initialize(XHistoframe_accel *InstancePtr, const char* InstanceName);
int XHistoframe_accel_Release(XHistoframe_accel *InstancePtr);
#endif

void XHistoframe_accel_Start(XHistoframe_accel *InstancePtr);
u32 XHistoframe_accel_IsDone(XHistoframe_accel *InstancePtr);
u32 XHistoframe_accel_IsIdle(XHistoframe_accel *InstancePtr);
u32 XHistoframe_accel_IsReady(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_Continue(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_EnableAutoRestart(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_DisableAutoRestart(XHistoframe_accel *InstancePtr);

void XHistoframe_accel_Set_dat_inp(XHistoframe_accel *InstancePtr, u64 Data);
u64 XHistoframe_accel_Get_dat_inp(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_Set_dat_out(XHistoframe_accel *InstancePtr, u64 Data);
u64 XHistoframe_accel_Get_dat_out(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_Set_rows_in(XHistoframe_accel *InstancePtr, u32 Data);
u32 XHistoframe_accel_Get_rows_in(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_Set_cols_in(XHistoframe_accel *InstancePtr, u32 Data);
u32 XHistoframe_accel_Get_cols_in(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_Set_rows_out(XHistoframe_accel *InstancePtr, u32 Data);
u32 XHistoframe_accel_Get_rows_out(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_Set_cols_out(XHistoframe_accel *InstancePtr, u32 Data);
u32 XHistoframe_accel_Get_cols_out(XHistoframe_accel *InstancePtr);

void XHistoframe_accel_InterruptGlobalEnable(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_InterruptGlobalDisable(XHistoframe_accel *InstancePtr);
void XHistoframe_accel_InterruptEnable(XHistoframe_accel *InstancePtr, u32 Mask);
void XHistoframe_accel_InterruptDisable(XHistoframe_accel *InstancePtr, u32 Mask);
void XHistoframe_accel_InterruptClear(XHistoframe_accel *InstancePtr, u32 Mask);
u32 XHistoframe_accel_InterruptGetEnabled(XHistoframe_accel *InstancePtr);
u32 XHistoframe_accel_InterruptGetStatus(XHistoframe_accel *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
