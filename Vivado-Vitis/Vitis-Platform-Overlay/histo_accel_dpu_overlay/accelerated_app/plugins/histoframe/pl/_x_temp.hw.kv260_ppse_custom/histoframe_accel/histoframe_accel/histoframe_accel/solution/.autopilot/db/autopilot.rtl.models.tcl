set SynModuleInfo {
  {SRCNAME entry_proc5 MODELNAME entry_proc5 RTLNAME histoframe_accel_entry_proc5}
  {SRCNAME Block_entry1_proc MODELNAME Block_entry1_proc RTLNAME histoframe_accel_Block_entry1_proc}
  {SRCNAME addrbound.1 MODELNAME addrbound_1 RTLNAME histoframe_accel_addrbound_1
    SUBMODULES {
      {MODELNAME histoframe_accel_mul_mul_16ns_16ns_22_4_1 RTLNAME histoframe_accel_mul_mul_16ns_16ns_22_4_1 BINDTYPE op TYPE all IMPL dsp48 LATENCY 3 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME Axi2Mat_Block_entry35_proc MODELNAME Axi2Mat_Block_entry35_proc RTLNAME histoframe_accel_Axi2Mat_Block_entry35_proc}
  {SRCNAME Axi2AxiStream_Pipeline_MMIterInLoop1 MODELNAME Axi2AxiStream_Pipeline_MMIterInLoop1 RTLNAME histoframe_accel_Axi2AxiStream_Pipeline_MMIterInLoop1
    SUBMODULES {
      {MODELNAME histoframe_accel_flow_control_loop_pipe_sequential_init RTLNAME histoframe_accel_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME histoframe_accel_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME Axi2AxiStream MODELNAME Axi2AxiStream RTLNAME histoframe_accel_Axi2AxiStream}
  {SRCNAME entry_proc3 MODELNAME entry_proc3 RTLNAME histoframe_accel_entry_proc3}
  {SRCNAME last_blk_pxl_width.1 MODELNAME last_blk_pxl_width_1 RTLNAME histoframe_accel_last_blk_pxl_width_1}
  {SRCNAME AxiStream2MatStream<2>_Pipeline_MMIterInLoopRow MODELNAME AxiStream2MatStream_2_Pipeline_MMIterInLoopRow RTLNAME histoframe_accel_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow}
  {SRCNAME AxiStream2MatStream<2> MODELNAME AxiStream2MatStream_2_s RTLNAME histoframe_accel_AxiStream2MatStream_2_s
    SUBMODULES {
      {MODELNAME histoframe_accel_mul_32s_32s_32_2_1 RTLNAME histoframe_accel_mul_32s_32s_32_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME AxiStream2Mat MODELNAME AxiStream2Mat RTLNAME histoframe_accel_AxiStream2Mat
    SUBMODULES {
      {MODELNAME histoframe_accel_fifo_w32_d3_S RTLNAME histoframe_accel_fifo_w32_d3_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME rows_c_U}
      {MODELNAME histoframe_accel_fifo_w32_d3_S RTLNAME histoframe_accel_fifo_w32_d3_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cols_c_U}
      {MODELNAME histoframe_accel_fifo_w4_d2_S RTLNAME histoframe_accel_fifo_w4_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME last_blk_width_channel_U}
    }
  }
  {SRCNAME Axi2Mat MODELNAME Axi2Mat RTLNAME histoframe_accel_Axi2Mat
    SUBMODULES {
      {MODELNAME histoframe_accel_fifo_w18_d2_S RTLNAME histoframe_accel_fifo_w18_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME p_channel_U}
      {MODELNAME histoframe_accel_fifo_w32_d4_S RTLNAME histoframe_accel_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME rows_c_U}
      {MODELNAME histoframe_accel_fifo_w32_d4_S RTLNAME histoframe_accel_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cols_c_U}
      {MODELNAME histoframe_accel_fifo_w18_d2_S RTLNAME histoframe_accel_fifo_w18_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME axibound_V_U}
      {MODELNAME histoframe_accel_fifo_w128_d2_S RTLNAME histoframe_accel_fifo_w128_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME ldata_U}
      {MODELNAME histoframe_accel_start_for_AxiStream2Mat_U0 RTLNAME histoframe_accel_start_for_AxiStream2Mat_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_AxiStream2Mat_U0_U}
    }
  }
  {SRCNAME {Array2xfMat<128, 0, 720, 2560, 1>} MODELNAME Array2xfMat_128_0_720_2560_1_s RTLNAME histoframe_accel_Array2xfMat_128_0_720_2560_1_s}
  {SRCNAME histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2 MODELNAME histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2 RTLNAME histoframe_accel_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2}
  {SRCNAME {histoframe<0, 9, 720, 2560, 720, 1280, 1, 2, 2>} MODELNAME histoframe_0_9_720_2560_720_1280_1_2_2_s RTLNAME histoframe_accel_histoframe_0_9_720_2560_720_1280_1_2_2_s
    SUBMODULES {
      {MODELNAME histoframe_accel_mul_32ns_32ns_64_2_1 RTLNAME histoframe_accel_mul_32ns_32ns_64_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME entry_proc4 MODELNAME entry_proc4 RTLNAME histoframe_accel_entry_proc4}
  {SRCNAME addrbound MODELNAME addrbound RTLNAME histoframe_accel_addrbound
    SUBMODULES {
      {MODELNAME histoframe_accel_mul_mul_16ns_16ns_26_4_1 RTLNAME histoframe_accel_mul_mul_16ns_16ns_26_4_1 BINDTYPE op TYPE all IMPL dsp48 LATENCY 3 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME Mat2Axi_Block_entry24_proc MODELNAME Mat2Axi_Block_entry24_proc RTLNAME histoframe_accel_Mat2Axi_Block_entry24_proc}
  {SRCNAME entry_proc MODELNAME entry_proc RTLNAME histoframe_accel_entry_proc}
  {SRCNAME last_blk_pxl_width MODELNAME last_blk_pxl_width RTLNAME histoframe_accel_last_blk_pxl_width}
  {SRCNAME MatStream2AxiStream<2>_Pipeline_MMIterOutRow_MMIterOutCol MODELNAME MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol RTLNAME histoframe_accel_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol}
  {SRCNAME MatStream2AxiStream<2> MODELNAME MatStream2AxiStream_2_s RTLNAME histoframe_accel_MatStream2AxiStream_2_s
    SUBMODULES {
      {MODELNAME histoframe_accel_mul_mul_16ns_16ns_32_4_1 RTLNAME histoframe_accel_mul_mul_16ns_16ns_32_4_1 BINDTYPE op TYPE all IMPL dsp48 LATENCY 3 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME Mat2AxiStream MODELNAME Mat2AxiStream RTLNAME histoframe_accel_Mat2AxiStream
    SUBMODULES {
      {MODELNAME histoframe_accel_fifo_w16_d3_S RTLNAME histoframe_accel_fifo_w16_d3_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME rows_c_U}
      {MODELNAME histoframe_accel_fifo_w32_d3_S_x RTLNAME histoframe_accel_fifo_w32_d3_S_x BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cols_c_U}
      {MODELNAME histoframe_accel_fifo_w4_d2_S_x RTLNAME histoframe_accel_fifo_w4_d2_S_x BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME last_blk_width_channel_U}
    }
  }
  {SRCNAME AxiStream2Axi_Pipeline_MMIterOutLoop2 MODELNAME AxiStream2Axi_Pipeline_MMIterOutLoop2 RTLNAME histoframe_accel_AxiStream2Axi_Pipeline_MMIterOutLoop2}
  {SRCNAME AxiStream2Axi MODELNAME AxiStream2Axi RTLNAME histoframe_accel_AxiStream2Axi}
  {SRCNAME Mat2Axi MODELNAME Mat2Axi RTLNAME histoframe_accel_Mat2Axi
    SUBMODULES {
      {MODELNAME histoframe_accel_fifo_w64_d4_S RTLNAME histoframe_accel_fifo_w64_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME dout_c_U}
      {MODELNAME histoframe_accel_fifo_w19_d2_S RTLNAME histoframe_accel_fifo_w19_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME p_channel_U}
      {MODELNAME histoframe_accel_fifo_w19_d2_S RTLNAME histoframe_accel_fifo_w19_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME axibound_V_U}
      {MODELNAME histoframe_accel_fifo_w128_d2_S_x RTLNAME histoframe_accel_fifo_w128_d2_S_x BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME ldata_U}
    }
  }
  {SRCNAME {xfMat2Array<128, 9, 720, 1280, 1, 1>} MODELNAME xfMat2Array_128_9_720_1280_1_1_s RTLNAME histoframe_accel_xfMat2Array_128_9_720_1280_1_1_s}
  {SRCNAME histoframe_accel MODELNAME histoframe_accel RTLNAME histoframe_accel IS_TOP 1
    SUBMODULES {
      {MODELNAME histoframe_accel_fifo_w64_d5_S RTLNAME histoframe_accel_fifo_w64_d5_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME dat_out_c_U}
      {MODELNAME histoframe_accel_fifo_w32_d4_S_x RTLNAME histoframe_accel_fifo_w32_d4_S_x BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME out_mat_rows_channel_U}
      {MODELNAME histoframe_accel_fifo_w32_d4_S_x RTLNAME histoframe_accel_fifo_w32_d4_S_x BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME out_mat_cols_channel_U}
      {MODELNAME histoframe_accel_fifo_w32_d2_S RTLNAME histoframe_accel_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME in_mat_rows_c9_channel_U}
      {MODELNAME histoframe_accel_fifo_w32_d2_S RTLNAME histoframe_accel_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME in_mat_cols_c10_channel_U}
      {MODELNAME histoframe_accel_fifo_w8_d2_S RTLNAME histoframe_accel_fifo_w8_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME in_mat_data_U}
      {MODELNAME histoframe_accel_fifo_w32_d2_S RTLNAME histoframe_accel_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME in_mat_rows_c_U}
      {MODELNAME histoframe_accel_fifo_w32_d2_S RTLNAME histoframe_accel_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME in_mat_cols_c_U}
      {MODELNAME histoframe_accel_fifo_w24_d2_S RTLNAME histoframe_accel_fifo_w24_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME out_mat_data_U}
      {MODELNAME histoframe_accel_start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0 RTLNAME histoframe_accel_start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U}
      {MODELNAME histoframe_accel_gmem1_m_axi RTLNAME histoframe_accel_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME histoframe_accel_gmem2_m_axi RTLNAME histoframe_accel_gmem2_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME histoframe_accel_control_s_axi RTLNAME histoframe_accel_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
