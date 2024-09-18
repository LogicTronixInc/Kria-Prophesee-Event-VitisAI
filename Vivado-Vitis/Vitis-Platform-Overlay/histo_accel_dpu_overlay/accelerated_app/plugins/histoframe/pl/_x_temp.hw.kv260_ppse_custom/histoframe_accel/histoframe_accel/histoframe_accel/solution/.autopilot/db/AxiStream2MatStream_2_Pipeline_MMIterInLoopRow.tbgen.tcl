set moduleName AxiStream2MatStream_2_Pipeline_MMIterInLoopRow
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
set C_modelName {AxiStream2MatStream<2>_Pipeline_MMIterInLoopRow}
set C_modelType { void 0 }
set C_modelArgList {
	{ bound int 32 regular  }
	{ sext_ln1033 int 5 regular  }
	{ cols_bound_per_npc_load int 32 regular  }
	{ ldata1 int 128 regular {fifo 0 volatile }  }
	{ sub int 32 regular  }
	{ last_blk_width_load int 4 regular  }
	{ sub5 int 8 regular  }
	{ add_ln1033 int 8 regular  }
	{ in_mat_data1 int 8 regular {fifo 1 volatile }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "bound", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "sext_ln1033", "interface" : "wire", "bitwidth" : 5, "direction" : "READONLY"} , 
 	{ "Name" : "cols_bound_per_npc_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ldata1", "interface" : "fifo", "bitwidth" : 128, "direction" : "READONLY"} , 
 	{ "Name" : "sub", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "last_blk_width_load", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "sub5", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "add_ln1033", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "in_mat_data1", "interface" : "fifo", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 23
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ldata1_dout sc_in sc_lv 128 signal 3 } 
	{ ldata1_num_data_valid sc_in sc_lv 2 signal 3 } 
	{ ldata1_fifo_cap sc_in sc_lv 2 signal 3 } 
	{ ldata1_empty_n sc_in sc_logic 1 signal 3 } 
	{ ldata1_read sc_out sc_logic 1 signal 3 } 
	{ in_mat_data1_din sc_out sc_lv 8 signal 8 } 
	{ in_mat_data1_num_data_valid sc_in sc_lv 2 signal 8 } 
	{ in_mat_data1_fifo_cap sc_in sc_lv 2 signal 8 } 
	{ in_mat_data1_full_n sc_in sc_logic 1 signal 8 } 
	{ in_mat_data1_write sc_out sc_logic 1 signal 8 } 
	{ bound sc_in sc_lv 32 signal 0 } 
	{ sext_ln1033 sc_in sc_lv 5 signal 1 } 
	{ cols_bound_per_npc_load sc_in sc_lv 32 signal 2 } 
	{ sub sc_in sc_lv 32 signal 4 } 
	{ last_blk_width_load sc_in sc_lv 4 signal 5 } 
	{ sub5 sc_in sc_lv 8 signal 6 } 
	{ add_ln1033 sc_in sc_lv 8 signal 7 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ldata1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "ldata1", "role": "dout" }} , 
 	{ "name": "ldata1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ldata1", "role": "num_data_valid" }} , 
 	{ "name": "ldata1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ldata1", "role": "fifo_cap" }} , 
 	{ "name": "ldata1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ldata1", "role": "empty_n" }} , 
 	{ "name": "ldata1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ldata1", "role": "read" }} , 
 	{ "name": "in_mat_data1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_mat_data1", "role": "din" }} , 
 	{ "name": "in_mat_data1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "in_mat_data1", "role": "num_data_valid" }} , 
 	{ "name": "in_mat_data1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "in_mat_data1", "role": "fifo_cap" }} , 
 	{ "name": "in_mat_data1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_mat_data1", "role": "full_n" }} , 
 	{ "name": "in_mat_data1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_mat_data1", "role": "write" }} , 
 	{ "name": "bound", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bound", "role": "default" }} , 
 	{ "name": "sext_ln1033", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "sext_ln1033", "role": "default" }} , 
 	{ "name": "cols_bound_per_npc_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cols_bound_per_npc_load", "role": "default" }} , 
 	{ "name": "sub", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "sub", "role": "default" }} , 
 	{ "name": "last_blk_width_load", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "last_blk_width_load", "role": "default" }} , 
 	{ "name": "sub5", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "sub5", "role": "default" }} , 
 	{ "name": "add_ln1033", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "add_ln1033", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "AxiStream2MatStream_2_Pipeline_MMIterInLoopRow",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "5", "EstimateLatencyMax" : "1843204",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "bound", "Type" : "None", "Direction" : "I"},
			{"Name" : "sext_ln1033", "Type" : "None", "Direction" : "I"},
			{"Name" : "cols_bound_per_npc_load", "Type" : "None", "Direction" : "I"},
			{"Name" : "ldata1", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "ldata1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "sub", "Type" : "None", "Direction" : "I"},
			{"Name" : "last_blk_width_load", "Type" : "None", "Direction" : "I"},
			{"Name" : "sub5", "Type" : "None", "Direction" : "I"},
			{"Name" : "add_ln1033", "Type" : "None", "Direction" : "I"},
			{"Name" : "in_mat_data1", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "in_mat_data1_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "MMIterInLoopRow", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter1", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter4", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter4", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	AxiStream2MatStream_2_Pipeline_MMIterInLoopRow {
		bound {Type I LastRead 0 FirstWrite -1}
		sext_ln1033 {Type I LastRead 0 FirstWrite -1}
		cols_bound_per_npc_load {Type I LastRead 0 FirstWrite -1}
		ldata1 {Type I LastRead 3 FirstWrite -1}
		sub {Type I LastRead 0 FirstWrite -1}
		last_blk_width_load {Type I LastRead 0 FirstWrite -1}
		sub5 {Type I LastRead 0 FirstWrite -1}
		add_ln1033 {Type I LastRead 0 FirstWrite -1}
		in_mat_data1 {Type O LastRead -1 FirstWrite 4}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "5", "Max" : "1843204"}
	, {"Name" : "Interval", "Min" : "5", "Max" : "1843204"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	bound { ap_none {  { bound in_data 0 32 } } }
	sext_ln1033 { ap_none {  { sext_ln1033 in_data 0 5 } } }
	cols_bound_per_npc_load { ap_none {  { cols_bound_per_npc_load in_data 0 32 } } }
	ldata1 { ap_fifo {  { ldata1_dout fifo_port_we 0 128 }  { ldata1_num_data_valid fifo_status_num_data_valid 0 2 }  { ldata1_fifo_cap fifo_update 0 2 }  { ldata1_empty_n fifo_status 0 1 }  { ldata1_read fifo_data 1 1 } } }
	sub { ap_none {  { sub in_data 0 32 } } }
	last_blk_width_load { ap_none {  { last_blk_width_load in_data 0 4 } } }
	sub5 { ap_none {  { sub5 in_data 0 8 } } }
	add_ln1033 { ap_none {  { add_ln1033 in_data 0 8 } } }
	in_mat_data1 { ap_fifo {  { in_mat_data1_din fifo_port_we 1 8 }  { in_mat_data1_num_data_valid fifo_status_num_data_valid 0 2 }  { in_mat_data1_fifo_cap fifo_update 0 2 }  { in_mat_data1_full_n fifo_status 0 1 }  { in_mat_data1_write fifo_data 1 1 } } }
}
