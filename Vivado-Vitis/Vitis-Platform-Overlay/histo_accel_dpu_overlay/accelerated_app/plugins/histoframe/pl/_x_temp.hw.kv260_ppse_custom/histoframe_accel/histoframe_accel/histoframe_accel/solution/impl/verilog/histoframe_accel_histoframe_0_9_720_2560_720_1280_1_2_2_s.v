// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module histoframe_accel_histoframe_0_9_720_2560_720_1280_1_2_2_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        p_src_rows_dout,
        p_src_rows_num_data_valid,
        p_src_rows_fifo_cap,
        p_src_rows_empty_n,
        p_src_rows_read,
        p_src_cols_dout,
        p_src_cols_num_data_valid,
        p_src_cols_fifo_cap,
        p_src_cols_empty_n,
        p_src_cols_read,
        in_mat_data1_dout,
        in_mat_data1_num_data_valid,
        in_mat_data1_fifo_cap,
        in_mat_data1_empty_n,
        in_mat_data1_read,
        out_mat_data2_din,
        out_mat_data2_num_data_valid,
        out_mat_data2_fifo_cap,
        out_mat_data2_full_n,
        out_mat_data2_write
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] p_src_rows_dout;
input  [1:0] p_src_rows_num_data_valid;
input  [1:0] p_src_rows_fifo_cap;
input   p_src_rows_empty_n;
output   p_src_rows_read;
input  [31:0] p_src_cols_dout;
input  [1:0] p_src_cols_num_data_valid;
input  [1:0] p_src_cols_fifo_cap;
input   p_src_cols_empty_n;
output   p_src_cols_read;
input  [7:0] in_mat_data1_dout;
input  [1:0] in_mat_data1_num_data_valid;
input  [1:0] in_mat_data1_fifo_cap;
input   in_mat_data1_empty_n;
output   in_mat_data1_read;
output  [23:0] out_mat_data2_din;
input  [1:0] out_mat_data2_num_data_valid;
input  [1:0] out_mat_data2_fifo_cap;
input   out_mat_data2_full_n;
output   out_mat_data2_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg p_src_rows_read;
reg p_src_cols_read;
reg in_mat_data1_read;
reg out_mat_data2_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    p_src_rows_blk_n;
reg    p_src_cols_blk_n;
reg   [31:0] cols_reg_69;
reg   [31:0] rows_reg_75;
wire    ap_CS_fsm_state2;
wire   [63:0] grp_fu_62_p2;
reg   [63:0] bound_reg_90;
wire    ap_CS_fsm_state3;
wire    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start;
wire    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done;
wire    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_idle;
wire    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_ready;
wire    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_in_mat_data1_read;
wire   [23:0] grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_out_mat_data2_din;
wire    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_out_mat_data2_write;
reg    grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start_reg;
wire    ap_CS_fsm_state4;
reg    ap_block_state1;
wire   [31:0] grp_fu_62_p0;
wire   [31:0] grp_fu_62_p1;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire   [63:0] grp_fu_62_p00;
wire   [63:0] grp_fu_62_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
#0 grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start_reg = 1'b0;
end

histoframe_accel_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2 grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start),
    .ap_done(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done),
    .ap_idle(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_idle),
    .ap_ready(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_ready),
    .in_mat_data1_dout(in_mat_data1_dout),
    .in_mat_data1_num_data_valid(2'd0),
    .in_mat_data1_fifo_cap(2'd0),
    .in_mat_data1_empty_n(in_mat_data1_empty_n),
    .in_mat_data1_read(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_in_mat_data1_read),
    .out_mat_data2_din(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_out_mat_data2_din),
    .out_mat_data2_num_data_valid(2'd0),
    .out_mat_data2_fifo_cap(2'd0),
    .out_mat_data2_full_n(out_mat_data2_full_n),
    .out_mat_data2_write(grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_out_mat_data2_write),
    .cols(cols_reg_69),
    .bound(bound_reg_90)
);

histoframe_accel_mul_32ns_32ns_64_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 64 ))
mul_32ns_32ns_64_2_1_U73(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_62_p0),
    .din1(grp_fu_62_p1),
    .ce(1'b1),
    .dout(grp_fu_62_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start_reg <= 1'b1;
        end else if ((grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_ready == 1'b1)) begin
            grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        bound_reg_90 <= grp_fu_62_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        cols_reg_69 <= p_src_cols_dout;
        rows_reg_75 <= p_src_rows_dout;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done == 1'b0)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

always @ (*) begin
    if (((grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        in_mat_data1_read = grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_in_mat_data1_read;
    end else begin
        in_mat_data1_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        out_mat_data2_write = grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_out_mat_data2_write;
    end else begin
        out_mat_data2_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_cols_blk_n = p_src_cols_empty_n;
    end else begin
        p_src_cols_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_cols_read = 1'b1;
    end else begin
        p_src_cols_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_rows_blk_n = p_src_rows_empty_n;
    end else begin
        p_src_rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_rows_read = 1'b1;
    end else begin
        p_src_rows_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            if (((grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_fu_62_p0 = grp_fu_62_p00;

assign grp_fu_62_p00 = rows_reg_75;

assign grp_fu_62_p1 = grp_fu_62_p10;

assign grp_fu_62_p10 = cols_reg_69;

assign grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start = grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_ap_start_reg;

assign out_mat_data2_din = grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46_out_mat_data2_din;

endmodule //histoframe_accel_histoframe_0_9_720_2560_720_1280_1_2_2_s