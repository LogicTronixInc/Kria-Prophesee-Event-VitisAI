// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xhistoframe_accel.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XHistoframe_accel_CfgInitialize(XHistoframe_accel *InstancePtr, XHistoframe_accel_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XHistoframe_accel_Start(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XHistoframe_accel_IsDone(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XHistoframe_accel_IsIdle(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XHistoframe_accel_IsReady(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XHistoframe_accel_Continue(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XHistoframe_accel_EnableAutoRestart(XHistoframe_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XHistoframe_accel_DisableAutoRestart(XHistoframe_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL, 0);
}

void XHistoframe_accel_Set_dat_inp(XHistoframe_accel *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_INP_DATA, (u32)(Data));
    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_INP_DATA + 4, (u32)(Data >> 32));
}

u64 XHistoframe_accel_Get_dat_inp(XHistoframe_accel *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_INP_DATA);
    Data += (u64)XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_INP_DATA + 4) << 32;
    return Data;
}

void XHistoframe_accel_Set_dat_out(XHistoframe_accel *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_OUT_DATA, (u32)(Data));
    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_OUT_DATA + 4, (u32)(Data >> 32));
}

u64 XHistoframe_accel_Get_dat_out(XHistoframe_accel *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_OUT_DATA);
    Data += (u64)XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_OUT_DATA + 4) << 32;
    return Data;
}

void XHistoframe_accel_Set_rows_in(XHistoframe_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_ROWS_IN_DATA, Data);
}

u32 XHistoframe_accel_Get_rows_in(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_ROWS_IN_DATA);
    return Data;
}

void XHistoframe_accel_Set_cols_in(XHistoframe_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_COLS_IN_DATA, Data);
}

u32 XHistoframe_accel_Get_cols_in(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_COLS_IN_DATA);
    return Data;
}

void XHistoframe_accel_Set_rows_out(XHistoframe_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_ROWS_OUT_DATA, Data);
}

u32 XHistoframe_accel_Get_rows_out(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_ROWS_OUT_DATA);
    return Data;
}

void XHistoframe_accel_Set_cols_out(XHistoframe_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_COLS_OUT_DATA, Data);
}

u32 XHistoframe_accel_Get_cols_out(XHistoframe_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_COLS_OUT_DATA);
    return Data;
}

void XHistoframe_accel_InterruptGlobalEnable(XHistoframe_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_GIE, 1);
}

void XHistoframe_accel_InterruptGlobalDisable(XHistoframe_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_GIE, 0);
}

void XHistoframe_accel_InterruptEnable(XHistoframe_accel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_IER);
    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_IER, Register | Mask);
}

void XHistoframe_accel_InterruptDisable(XHistoframe_accel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_IER);
    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XHistoframe_accel_InterruptClear(XHistoframe_accel *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHistoframe_accel_WriteReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_ISR, Mask);
}

u32 XHistoframe_accel_InterruptGetEnabled(XHistoframe_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_IER);
}

u32 XHistoframe_accel_InterruptGetStatus(XHistoframe_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHistoframe_accel_ReadReg(InstancePtr->Control_BaseAddress, XHISTOFRAME_ACCEL_CONTROL_ADDR_ISR);
}

