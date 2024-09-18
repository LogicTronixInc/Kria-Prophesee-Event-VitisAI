set moduleName MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set C_modelName {MatStream2AxiStream<2>_Pipeline_MMIterOutRow_MMIterOutCol}
set C_modelType { void 0 }
set C_modelArgList {
	{ bound int 32 regular  }
	{ strideBased_cols_bound_per_npc_V int 16 regular  }
	{ op2_assign int 32 regular  }
	{ last_blk_width_load int 4 regular  }
	{ cols_bound_per_npc_load int 32 regular  }
	{ out_mat_data2 int 24 regular {fifo 0 volatile }  }
	{ ldata1 int 128 regular {fifo 1 volatile }  }
	{ localbuffer_V_3_out int 128 regular {pointer 1}  }
	{ filled_V_1_out int 8 regular {pointer 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "bound", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "strideBased_cols_bound_per_npc_V", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "op2_assign", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "last_blk_width_load", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "cols_bound_per_npc_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "out_mat_data2", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "ldata1", "interface" : "fifo", "bitwidth" : 128, "direction" : "WRITEONLY"} , 
 	{ "Name" : "localbuffer_V_3_out", "interface" : "wire", "bitwidth" : 128, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filled_V_1_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 25
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ out_mat_data2_dout sc_in sc_lv 24 signal 5 } 
	{ out_mat_data2_num_data_valid sc_in sc_lv 2 signal 5 } 
	{ out_mat_data2_fifo_cap sc_in sc_lv 2 signal 5 } 
	{ out_mat_data2_empty_n sc_in sc_logic 1 signal 5 } 
	{ out_mat_data2_read sc_out sc_logic 1 signal 5 } 
	{ ldata1_din sc_out sc_lv 128 signal 6 } 
	{ ldata1_num_data_valid sc_in sc_lv 2 signal 6 } 
	{ ldata1_fifo_cap sc_in sc_lv 2 signal 6 } 
	{ ldata1_full_n sc_in sc_logic 1 signal 6 } 
	{ ldata1_write sc_out sc_logic 1 signal 6 } 
	{ bound sc_in sc_lv 32 signal 0 } 
	{ strideBased_cols_bound_per_npc_V sc_in sc_lv 16 signal 1 } 
	{ op2_assign sc_in sc_lv 32 signal 2 } 
	{ last_blk_width_load sc_in sc_lv 4 signal 3 } 
	{ cols_bound_per_npc_load sc_in sc_lv 32 signal 4 } 
	{ localbuffer_V_3_out sc_out sc_lv 128 signal 7 } 
	{ localbuffer_V_3_out_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ filled_V_1_out sc_out sc_lv 8 signal 8 } 
	{ filled_V_1_out_ap_vld sc_out sc_logic 1 outvld 8 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "out_mat_data2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "out_mat_data2", "role": "dout" }} , 
 	{ "name": "out_mat_data2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "out_mat_data2", "role": "num_data_valid" }} , 
 	{ "name": "out_mat_data2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "out_mat_data2", "role": "fifo_cap" }} , 
 	{ "name": "out_mat_data2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_mat_data2", "role": "empty_n" }} , 
 	{ "name": "out_mat_data2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_mat_data2", "role": "read" }} , 
 	{ "name": "ldata1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "ldata1", "role": "din" }} , 
 	{ "name": "ldata1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ldata1", "role": "num_data_valid" }} , 
 	{ "name": "ldata1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ldata1", "role": "fifo_cap" }} , 
 	{ "name": "ldata1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ldata1", "role": "full_n" }} , 
 	{ "name": "ldata1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ldata1", "role": "write" }} , 
 	{ "name": "bound", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bound", "role": "default" }} , 
 	{ "name": "strideBased_cols_bound_per_npc_V", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "strideBased_cols_bound_per_npc_V", "role": "default" }} , 
 	{ "name": "op2_assign", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "op2_assign", "role": "default" }} , 
 	{ "name": "last_blk_width_load", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "last_blk_width_load", "role": "default" }} , 
 	{ "name": "cols_bound_per_npc_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cols_bound_per_npc_load", "role": "default" }} , 
 	{ "name": "localbuffer_V_3_out", "direction": "out", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "localbuffer_V_3_out", "role": "default" }} , 
 	{ "name": "localbuffer_V_3_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "localbuffer_V_3_out", "role": "ap_vld" }} , 
 	{ "name": "filled_V_1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filled_V_1_out", "role": "default" }} , 
 	{ "name": "filled_V_1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filled_V_1_out", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "5", "EstimateLatencyMax" : "921604",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "bound", "Type" : "None", "Direction" : "I"},
			{"Name" : "strideBased_cols_bound_per_npc_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "op2_assign", "Type" : "None", "Direction" : "I"},
			{"Name" : "last_blk_width_load", "Type" : "None", "Direction" : "I"},
			{"Name" : "cols_bound_per_npc_load", "Type" : "None", "Direction" : "I"},
			{"Name" : "out_mat_data2", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "out_mat_data2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ldata1", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "ldata1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "localbuffer_V_3_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filled_V_1_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "MMIterOutRow_MMIterOutCol", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter1", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter4", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter3", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol {
		bound {Type I LastRead 0 FirstWrite -1}
		strideBased_cols_bound_per_npc_V {Type I LastRead 0 FirstWrite -1}
		op2_assign {Type I LastRead 0 FirstWrite -1}
		last_blk_width_load {Type I LastRead 0 FirstWrite -1}
		cols_bound_per_npc_load {Type I LastRead 0 FirstWrite -1}
		out_mat_data2 {Type I LastRead 3 FirstWrite -1}
		ldata1 {Type O LastRead -1 FirstWrite 4}
		localbuffer_V_3_out {Type O LastRead -1 FirstWrite 3}
		filled_V_1_out {Type O LastRead -1 FirstWrite 3}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "5", "Max" : "921604"}
	, {"Name" : "Interval", "Min" : "5", "Max" : "921604"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	bound { ap_none {  { bound in_data 0 32 } } }
	strideBased_cols_bound_per_npc_V { ap_none {  { strideBased_cols_bound_per_npc_V in_data 0 16 } } }
	op2_assign { ap_none {  { op2_assign in_data 0 32 } } }
	last_blk_width_load { ap_none {  { last_blk_width_load in_data 0 4 } } }
	cols_bound_per_npc_load { ap_none {  { cols_bound_per_npc_load in_data 0 32 } } }
	out_mat_data2 { ap_fifo {  { out_mat_data2_dout fifo_port_we 0 24 }  { out_mat_data2_num_data_valid fifo_status_num_data_valid 0 2 }  { out_mat_data2_fifo_cap fifo_update 0 2 }  { out_mat_data2_empty_n fifo_status 0 1 }  { out_mat_data2_read fifo_data 1 1 } } }
	ldata1 { ap_fifo {  { ldata1_din fifo_port_we 1 128 }  { ldata1_num_data_valid fifo_status_num_data_valid 0 2 }  { ldata1_fifo_cap fifo_update 0 2 }  { ldata1_full_n fifo_status 0 1 }  { ldata1_write fifo_data 1 1 } } }
	localbuffer_V_3_out { ap_vld {  { localbuffer_V_3_out out_data 1 128 }  { localbuffer_V_3_out_ap_vld out_vld 1 1 } } }
	filled_V_1_out { ap_vld {  { filled_V_1_out out_data 1 8 }  { filled_V_1_out_ap_vld out_vld 1 1 } } }
}
