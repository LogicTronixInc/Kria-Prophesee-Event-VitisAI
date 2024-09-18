   
    parameter PROC_NUM = 20;
    parameter ST_IDLE = 3'b000;
    parameter ST_FILTER_FAKE = 3'b001;
    parameter ST_DL_DETECTED = 3'b010;
    parameter ST_DL_REPORT = 3'b100;
   

    reg [2:0] CS_fsm;
    reg [2:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    reg [31:0] dl_keep_cnt;
    integer i;
    integer fp;

    // FSM State machine
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end
    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg or dl_keep_cnt) begin
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_FILTER_FAKE;
                end
                else begin
                    NS_fsm = ST_IDLE;
                end
            end
            ST_FILTER_FAKE: begin
                if (dl_keep_cnt >= 32'd1000) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else if (dl_detect_reg != (dl_detect_reg & dl_in_vec)) begin
                    NS_fsm = ST_IDLE;
                end
                else begin
                    NS_fsm = ST_FILTER_FAKE;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if (dl_detect_reg != dl_done_reg) begin
                    NS_fsm = ST_DL_REPORT;
                end
                else begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            default: NS_fsm = ST_IDLE;
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_keep_cnt <= 32'h0;
        end
        else begin
            if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg == (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= dl_keep_cnt + 32'h1;
            end
            else if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg != (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= 32'h0;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = (|dl_detect_reg) && (CS_fsm == ST_DL_DETECTED || CS_fsm == ST_DL_REPORT);

    // dl_done_reg record the cycles has been reported
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    wire [PROC_NUM*PROC_NUM - 1:0] origin_tmp;
    assign origin_tmp[PROC_NUM - 1:0] = (dl_detect_reg[0] & ~dl_done_reg[0]) ? 'b1 : 'b0;
    genvar j;
    generate
    for(j = 1;j < PROC_NUM;j = j + 1) begin: F1
        assign origin_tmp[j*PROC_NUM +: PROC_NUM] = (dl_detect_reg[j] & ~dl_done_reg[j]) ? ('b1 << j) : origin_tmp[(j - 1)*PROC_NUM +: PROC_NUM];
    end
    endgenerate
    always @ (CS_fsm or origin_tmp) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            origin = origin_tmp[(PROC_NUM - 1)*PROC_NUM +: PROC_NUM];
        end
        else begin
            origin = 'b0;
        end
    end

    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // find_df_deadlock to report the deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            find_df_deadlock <= 1'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED && dl_detect_reg == dl_done_reg) begin
                find_df_deadlock <= 1'b1;
            end
            else if (CS_fsm == ST_IDLE) begin
                find_df_deadlock <= 1'b0;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [1056:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "histoframe_accel_histoframe_accel.entry_proc5_U0";
                end
                1 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Block_entry1_proc_U0";
                end
                2 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0";
                end
                3 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0";
                end
                4 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2Mat_Block_entry35_proc_U0";
                end
                5 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0";
                end
                6 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0";
                end
                7 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0";
                end
                8 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_pxl_width_1_U0";
                end
                9 : begin
                    proc_path = "histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0";
                end
                10 : begin
                    proc_path = "histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0";
                end
                11 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0";
                end
                12 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0";
                end
                13 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0";
                end
                14 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2Axi_Block_entry24_proc_U0";
                end
                15 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0";
                end
                16 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0";
                end
                17 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_pxl_width_U0";
                end
                18 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0";
                end
                19 : begin
                    proc_path = "histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [1056:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", record_time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [1056:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [1056:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin
                    case(index2)
                    11: begin
                        if (~entry_proc5_U0.dat_out_c_blk_n) begin
                            if (~dat_out_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.dat_out_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.dat_out_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~dat_out_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.dat_out_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.dat_out_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin
                        if (ap_sync_entry_proc5_U0_ap_ready & entry_proc5_U0.ap_idle & ~ap_sync_Block_entry1_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                        end
                    end
                    2: begin
                        if (ap_sync_entry_proc5_U0_ap_ready & entry_proc5_U0.ap_idle & ~ap_sync_Array2xfMat_128_0_720_2560_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                        end
                    end
                    endcase
                end
                1 : begin
                    case(index2)
                    0: begin
                        if (ap_sync_Block_entry1_proc_U0_ap_ready & Block_entry1_proc_U0.ap_idle & ~ap_sync_entry_proc5_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.entry_proc5_U0'");
                        end
                    end
                    2: begin
                        if (ap_sync_Block_entry1_proc_U0_ap_ready & Block_entry1_proc_U0.ap_idle & ~ap_sync_Array2xfMat_128_0_720_2560_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                        end
                    end
                    endcase
                end
                2 : begin
                    case(index2)
                    1: begin
                        if (~in_mat_rows_c9_channel_U.if_empty_n & Array2xfMat_128_0_720_2560_1_U0.ap_idle & ~in_mat_rows_c9_channel_U.if_write) begin
                            if (~in_mat_rows_c9_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_rows_c9_channel_U' written by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_rows_c9_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_rows_c9_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_rows_c9_channel_U' read by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_rows_c9_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~in_mat_cols_c10_channel_U.if_empty_n & Array2xfMat_128_0_720_2560_1_U0.ap_idle & ~in_mat_cols_c10_channel_U.if_write) begin
                            if (~in_mat_cols_c10_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_cols_c10_channel_U' written by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_cols_c10_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_cols_c10_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_cols_c10_channel_U' read by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_cols_c10_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (ap_sync_Array2xfMat_128_0_720_2560_1_U0_ap_ready & Array2xfMat_128_0_720_2560_1_U0.ap_idle & ~ap_sync_Block_entry1_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                        end
                    end
                    10: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_62.in_mat_data1_blk_n) begin
                            if (~in_mat_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_data_U' written by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_data_U' read by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.in_mat_rows_c_blk_n) begin
                            if (~in_mat_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_rows_c_U' written by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_rows_c_U' read by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.in_mat_cols_c_blk_n) begin
                            if (~in_mat_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_cols_c_U' written by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_cols_c_U' read by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U.if_full_n & Array2xfMat_128_0_720_2560_1_U0.ap_start & ~Array2xfMat_128_0_720_2560_1_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'histoframe_accel_histoframe_accel.start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U' read by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0',");
                        end
                    end
                    0: begin
                        if (ap_sync_Array2xfMat_128_0_720_2560_1_U0_ap_ready & Array2xfMat_128_0_720_2560_1_U0.ap_idle & ~ap_sync_entry_proc5_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.entry_proc5_U0'");
                        end
                    end
                    endcase
                end
                3 : begin
                    case(index2)
                    4: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_full_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.ap_done & ap_done_reg_1 & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_read) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2Mat_Block_entry35_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2Mat_Block_entry35_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.rows_c_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.cols_c_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.start_for_AxiStream2Mat_U0_U.if_full_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.ap_start & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.start_for_AxiStream2Mat_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.start_for_AxiStream2Mat_U0_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0',");
                        end
                    end
                    7: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.rows_c_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.cols_c_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin
                        if (Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ap_sync_addrbound_1_U0_ap_ready & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ap_sync_Axi2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0'");
                        end
                    end
                    endcase
                end
                4 : begin
                    case(index2)
                    3: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_empty_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2Mat_Block_entry35_proc_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_write) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                5 : begin
                    case(index2)
                    6: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0.grp_Axi2AxiStream_Pipeline_MMIterInLoop1_fu_64.ldata1_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0.grp_Axi2AxiStream_Pipeline_MMIterInLoop1_fu_64.ldata1_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U.if_empty_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U.if_write) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2Mat_Block_entry35_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2Mat_Block_entry35_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ap_sync_Axi2AxiStream_U0_ap_ready & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ap_sync_addrbound_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                        end
                    end
                    endcase
                end
                6 : begin
                    case(index2)
                    5: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_62.ldata1_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.rows_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.cols_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.start_for_AxiStream2Mat_U0_U.if_empty_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.start_for_AxiStream2Mat_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.start_for_AxiStream2Mat_U0_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0',");
                        end
                    end
                    endcase
                end
                7 : begin
                    case(index2)
                    3: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.rows_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.cols_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.addrbound_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.rows_c_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.cols_c_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin
                        if (Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.ap_sync_entry_proc3_U0_ap_ready & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.ap_sync_last_blk_pxl_width_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_pxl_width_1_U0'");
                        end
                    end
                    endcase
                end
                8 : begin
                    case(index2)
                    9: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_full_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_pxl_width_1_U0.ap_done & ap_done_reg_4 & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_read) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin
                        if (Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.ap_sync_last_blk_pxl_width_1_U0_ap_ready & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_pxl_width_1_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.ap_sync_entry_proc3_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                        end
                    end
                    endcase
                end
                9 : begin
                    case(index2)
                    5: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_62.ldata1_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.rows_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.cols_bound_per_npc_blk_n) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.entry_proc3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin
                        if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_empty_n & Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.ap_idle & ~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_write) begin
                            if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_pxl_width_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_pxl_width_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0.grp_Axi2Mat_fu_86.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                10 : begin
                    case(index2)
                    2: begin
                        if (~histoframe_0_9_720_2560_720_1280_1_2_2_U0.p_src_rows_blk_n) begin
                            if (~in_mat_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_rows_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_rows_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~histoframe_0_9_720_2560_720_1280_1_2_2_U0.p_src_cols_blk_n) begin
                            if (~in_mat_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_cols_c_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_cols_c_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~histoframe_0_9_720_2560_720_1280_1_2_2_U0.grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46.in_mat_data1_blk_n) begin
                            if (~in_mat_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.in_mat_data_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~in_mat_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.in_mat_data_U' read by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.in_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U.if_empty_n & histoframe_0_9_720_2560_720_1280_1_2_2_U0.ap_idle & ~start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'histoframe_accel_histoframe_accel.start_for_histoframe_0_9_720_2560_720_1280_1_2_2_U0_U' written by process 'histoframe_accel_histoframe_accel.Array2xfMat_128_0_720_2560_1_U0',");
                        end
                    end
                    11: begin
                        if (~histoframe_0_9_720_2560_720_1280_1_2_2_U0.grp_histoframe_Pipeline_VITIS_LOOP_26_1_VITIS_LOOP_28_2_fu_46.out_mat_data2_blk_n) begin
                            if (~out_mat_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.out_mat_data_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~out_mat_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.out_mat_data_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                11 : begin
                    case(index2)
                    1: begin
                        if (~out_mat_rows_channel_U.if_empty_n & xfMat2Array_128_9_720_1280_1_1_U0.ap_idle & ~out_mat_rows_channel_U.if_write) begin
                            if (~out_mat_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.out_mat_rows_channel_U' written by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~out_mat_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.out_mat_rows_channel_U' read by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~out_mat_cols_channel_U.if_empty_n & xfMat2Array_128_9_720_1280_1_1_U0.ap_idle & ~out_mat_cols_channel_U.if_write) begin
                            if (~out_mat_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.out_mat_cols_channel_U' written by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~out_mat_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.out_mat_cols_channel_U' read by process 'histoframe_accel_histoframe_accel.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.grp_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol_fu_79.out_mat_data2_blk_n) begin
                            if (~out_mat_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.out_mat_data_U' written by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~out_mat_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.out_mat_data_U' read by process 'histoframe_accel_histoframe_accel.histoframe_0_9_720_2560_720_1280_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.out_mat_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.dstPtr_blk_n) begin
                            if (~dat_out_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.dat_out_c_U' written by process 'histoframe_accel_histoframe_accel.entry_proc5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.dat_out_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~dat_out_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.dat_out_c_U' read by process 'histoframe_accel_histoframe_accel.entry_proc5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.dat_out_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                12 : begin
                    case(index2)
                    19: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0.dout_c_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_entry_proc4_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_addrbound_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0'");
                        end
                    end
                    15: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_entry_proc4_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_Mat2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0'");
                        end
                    end
                    endcase
                end
                13 : begin
                    case(index2)
                    14: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_full_n & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0.ap_done & ap_done_reg_7 & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_read) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2Axi_Block_entry24_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2Axi_Block_entry24_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_addrbound_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_entry_proc4_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0'");
                        end
                    end
                    15: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_addrbound_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_Mat2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0'");
                        end
                    end
                    endcase
                end
                14 : begin
                    case(index2)
                    13: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_empty_n & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2Axi_Block_entry24_proc_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_write) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                15 : begin
                    case(index2)
                    19: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.grp_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol_fu_79.ldata1_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_Mat2AxiStream_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_entry_proc4_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0'");
                        end
                    end
                    13: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_Mat2AxiStream_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ap_sync_addrbound_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.addrbound_U0'");
                        end
                    end
                    endcase
                end
                16 : begin
                    case(index2)
                    18: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0.rows_c_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0.cols_c_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.ap_sync_entry_proc_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.ap_sync_last_blk_pxl_width_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_pxl_width_U0'");
                        end
                    end
                    endcase
                end
                17 : begin
                    case(index2)
                    18: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_full_n & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_pxl_width_U0.ap_done & ap_done_reg_9 & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_read) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin
                        if (xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.ap_sync_last_blk_pxl_width_U0_ap_ready & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_pxl_width_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.ap_sync_entry_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0'");
                        end
                    end
                    endcase
                end
                18 : begin
                    case(index2)
                    19: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.ldata1_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.rows_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.cols_bound_per_npc_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_empty_n & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_write) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_pxl_width_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_pxl_width_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                19 : begin
                    case(index2)
                    15: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0.grp_AxiStream2Axi_Pipeline_MMIterOutLoop2_fu_75.ldata1_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0.grp_AxiStream2Axi_Pipeline_MMIterOutLoop2_fu_75.ldata1_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2AxiStream_U0.MatStream2AxiStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0.dout_blk_n) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.entry_proc4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.dout_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    14: begin
                        if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U.if_empty_n & xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.AxiStream2Axi_U0.ap_idle & ~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U.if_write) begin
                            if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U' written by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2Axi_Block_entry24_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U' read by process 'histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.Mat2Axi_Block_entry24_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path histoframe_accel_histoframe_accel.xfMat2Array_128_9_720_1280_1_1_U0.grp_Mat2Axi_fu_64.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (dl_reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge dl_clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        @(negedge dl_clock);
                        @(negedge dl_clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
