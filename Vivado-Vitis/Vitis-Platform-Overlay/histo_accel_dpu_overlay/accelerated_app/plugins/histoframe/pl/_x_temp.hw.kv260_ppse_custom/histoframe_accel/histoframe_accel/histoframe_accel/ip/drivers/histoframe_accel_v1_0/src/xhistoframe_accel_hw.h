// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 4  - ap_continue (Read/Write/SC)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of dat_inp
//        bit 31~0 - dat_inp[31:0] (Read/Write)
// 0x14 : Data signal of dat_inp
//        bit 31~0 - dat_inp[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of dat_out
//        bit 31~0 - dat_out[31:0] (Read/Write)
// 0x20 : Data signal of dat_out
//        bit 31~0 - dat_out[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of rows_in
//        bit 31~0 - rows_in[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of cols_in
//        bit 31~0 - cols_in[31:0] (Read/Write)
// 0x34 : reserved
// 0x38 : Data signal of rows_out
//        bit 31~0 - rows_out[31:0] (Read/Write)
// 0x3c : reserved
// 0x40 : Data signal of cols_out
//        bit 31~0 - cols_out[31:0] (Read/Write)
// 0x44 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XHISTOFRAME_ACCEL_CONTROL_ADDR_AP_CTRL       0x00
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_GIE           0x04
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_IER           0x08
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_ISR           0x0c
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_INP_DATA  0x10
#define XHISTOFRAME_ACCEL_CONTROL_BITS_DAT_INP_DATA  64
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_DAT_OUT_DATA  0x1c
#define XHISTOFRAME_ACCEL_CONTROL_BITS_DAT_OUT_DATA  64
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_ROWS_IN_DATA  0x28
#define XHISTOFRAME_ACCEL_CONTROL_BITS_ROWS_IN_DATA  32
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_COLS_IN_DATA  0x30
#define XHISTOFRAME_ACCEL_CONTROL_BITS_COLS_IN_DATA  32
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_ROWS_OUT_DATA 0x38
#define XHISTOFRAME_ACCEL_CONTROL_BITS_ROWS_OUT_DATA 32
#define XHISTOFRAME_ACCEL_CONTROL_ADDR_COLS_OUT_DATA 0x40
#define XHISTOFRAME_ACCEL_CONTROL_BITS_COLS_OUT_DATA 32

