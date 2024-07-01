logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ source /opt/xilinx/xrt/setup.sh 
Autocomplete enabled for the xbutil command
Autocomplete enabled for the xbmgmt command
XILINX_XRT        : /opt/xilinx/xrt
PATH              : /opt/xilinx/xrt/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis_HLS/2022.2/bin:/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/microblaze/lin/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/arm/lin/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/microblaze/linux_toolchain/lin64_le/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/aarch64/lin/aarch64-linux/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/aarch64/lin/aarch64-none/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/gnu/armr5/lin/gcc-arm-none-eabi/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/tps/lnx64/cmake-3.3.2/bin:/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/aietools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin
LD_LIBRARY_PATH   : /opt/xilinx/xrt/lib
PYTHONPATH        : /opt/xilinx/xrt/python
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ ls
config_file  doc  dpu_conf.vh  dpu_settings  kernel_xml  Makefile  platforms  README.md  scripts  scripts_gui  syslink
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ export EDGE_COMMON_SW=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260_vitis_platform/xilinx-zynqmp-common-v2022.2
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ export SDX_PLATFORM=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ export SDX_PLATFORM=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$  make all KERNEL=DPU DEVICE=KV260
/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/bin/vivado -mode batch -source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace -tclargs binary_container_1/dpu.xo DPUCZDX8G hw KV260

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace
binary_container_1/dpu.xo
INFO: [IP_Flow 19-5654] Module 'DPUCZDX8G' uses SystemVerilog sources with a Verilog top file. These SystemVerilog files will not be analysed by the packager.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_def.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagesynthesis.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagebehavioralsimulation.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_para.vh" from the top-level HDL file.
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_GP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP2' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'S_AXI_CONTROL' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'interrupt' of definition 'xilinx.com:signal:interrupt:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-4728] Bus Interface 'interrupt': Added interface parameter 'SENSITIVITY' with value 'LEVEL_HIGH'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_BUSIF' with value 'M_AXI_GP0'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_RESET' with value 'aresetn'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_clk_2': Added interface parameter 'ASSOCIATED_RESET' with value 'ap_rst_n_2'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_rst_n_2': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
INFO: [IP_Flow 19-4728] Bus Interface 'aresetn': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
WARNING: [IP_Flow 19-5661] Bus Interface 'ap_clk_2' does not have any bus interfaces associated with it.
WARNING: [IP_Flow 19-3157] Bus Interface 'ap_rst_n_2': Bus parameter POLARITY is ACTIVE_LOW but port 'ap_rst_n_2' is not *resetn - please double check the POLARITY setting.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagesynthesis (Synthesis)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Synthesis file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Synthesis'.
Resolution: Remove the file from the specified file group.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagebehavioralsimulation (Simulation)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Simulation file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Simulation'.
Resolution: Remove the file from the specified file group.
INFO: [IP_Flow 19-2181] Payment Required is not set for this core.
INFO: [IP_Flow 19-2187] The Product Guide file is missing.
INFO: [IP_Flow 19-795] Syncing license key meta-data
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from TCL Argument).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from TCL Argument).
WARNING: [Vivado 12-4404] The CPU emulation flow in v++ is only supported when using a packaged XO file that contains C-model files, none were found.
INFO: [Common 17-206] Exiting Vivado at Mon Jun 10 14:28:49 2024...
v++ -t hw --platform /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --save-temps --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/config_file/prj_config_1dpu --xp param:compiler.userPostSysLinkOverlayTcl=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/syslink/strip_interconnects.tcl  -l --temp_dir binary_container_1 --log_dir binary_container_1/logs --remote_ip_cache binary_container_1/ip_cache -o "binary_container_1/binary_container_1.xclbin" binary_container_1/dpu.xo
WARNING: [v++ 60-1600] The option 'xp' was used directly on the command line, where its usage is deprecated. To ensure input line works for supported operating systems or shells, v++ supports specification for some options in a configuration file. As an alternative, please use options 'advanced.*', 'vivado.*' in a configuration file. Use one or more configuration files along with section headers to define key-value pairs for the advanced properties or parameters. Specify a configuration file using '--config'.
INFO: [v++ 82-185] Check out the auto-generated 'sample_link.ini' configuration file. The file shows how to migrate from deprecated command line --xp switches to configuration file directives.
Option Map File Used: '/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/data/vitis/vpp/optMap.xml'

****** v++ v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [v++ 60-1306] Additional information associated with this v++ link can be found at:
	Reports: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link
	Log files: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link
Running Dispatch Server on port: 38653
INFO: [v++ 60-1548] Creating build summary session with primary output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.link_summary, at Mon Jun 10 14:29:03 2024
INFO: [v++ 60-1315] Creating rulecheck session with output '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/v++_link_binary_container_1_guidance.html', at Mon Jun 10 14:29:03 2024
INFO: [v++ 60-895]   Target platform: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm
INFO: [v++ 60-1578]   This platform contains Xilinx Shell Archive '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/hw/kv260_ppse_hardware_platform.xsa'
INFO: [v++ 60-629] Linking for hardware target
INFO: [v++ 60-423]   Target device: kv260_ppse_custom
INFO: [v++ 60-1332] Run 'run_link' status: Not started
INFO: [v++ 60-1443] [14:29:03] Run run_link: Step system_link: Started
INFO: [v++ 60-1453] Command Line: system_link --xo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo -keep --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/syslinkConfig.ini --xpfm /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --target hw --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [SYSTEM_LINK 82-70] Extracting xo v3 file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo
INFO: [SYSTEM_LINK 82-53] Creating IP database /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-38] [14:29:04] build_xd_ip_db started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/build_xd_ip_db -ip_search 0  -sds-pf /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/kv260_ppse_hardware_platform.hpfm -clkid 1 -ip /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/iprepo/xilinx_com_RTLKernel_DPUCZDX8G_1_0,DPUCZDX8G -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-37] [14:29:07] build_xd_ip_db finished successfully
Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 24018 ; free virtual = 29360
INFO: [SYSTEM_LINK 82-51] Create system connectivity graph
INFO: [SYSTEM_LINK 82-102] Applying explicit connections to the system connectivity graph: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [SYSTEM_LINK 82-38] [14:29:07] cfgen started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cfgen  -sp DPUCZDX8G_1.M_AXI_GP0:HPC1 -sp DPUCZDX8G_1.M_AXI_HP0:HP0 -sp DPUCZDX8G_1.M_AXI_HP2:HP1 -clock.freqHz 200000000:DPUCZDX8G_1.aclk -clock.freqHz 400000000:DPUCZDX8G_1.ap_clk_2 -dpa_mem_offload false -dmclkid 1 -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [CFGEN 83-0] Kernel Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G, num: 1  {DPUCZDX8G_1}
INFO: [CFGEN 83-0] Port Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_GP0, sptag: HPC1
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP0, sptag: HP0
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP2, sptag: HP1
INFO: [SYSTEM_LINK 82-37] [14:29:07] cfgen finished successfully
Time (s): cpu = 00:00:00.65 ; elapsed = 00:00:00.69 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 24017 ; free virtual = 29360
INFO: [SYSTEM_LINK 82-52] Create top-level block diagram
INFO: [SYSTEM_LINK 82-38] [14:29:07] cf2bd started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cf2bd  --linux --trace_buffer 1024 --input_file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml --ip_db /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml --cf_name dr --working_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int
INFO: [CF2BD 82-31] Launching cf2xd: cf2xd -linux -trace-buffer 1024 -i /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o dr.xml
INFO: [CF2BD 82-28] cf2xd finished successfully
INFO: [CF2BD 82-31] Launching cf_xsd: cf_xsd -disable-address-gen -dn dr -dp /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd
INFO: [CF2BD 82-28] cf_xsd finished successfully
INFO: [SYSTEM_LINK 82-37] [14:29:08] cf2bd finished successfully
Time (s): cpu = 00:00:00.97 ; elapsed = 00:00:01 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 24016 ; free virtual = 29364
INFO: [v++ 60-1441] [14:29:08] Run run_link: Step system_link: Completed
Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 458.402 ; gain = 0.000 ; free physical = 24075 ; free virtual = 29422
INFO: [v++ 60-1443] [14:29:08] Run run_link: Step cf2sw: Started
INFO: [v++ 60-1453] Command Line: cf2sw -sdsl /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/sdsl.dat -rtd /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw.rtd -nofilter /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw_full.rtd -xclbin /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.1.xml
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [14:29:09] Run run_link: Step cf2sw: Completed
Time (s): cpu = 00:00:00.88 ; elapsed = 00:00:00.93 . Memory (MB): peak = 458.402 ; gain = 0.000 ; free physical = 24078 ; free virtual = 29429
INFO: [v++ 60-1443] [14:29:09] Run run_link: Step rtd2_system_diagram: Started
INFO: [v++ 60-1453] Command Line: rtd2SystemDiagram
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [14:29:09] Run run_link: Step rtd2_system_diagram: Completed
Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.04 . Memory (MB): peak = 458.402 ; gain = 0.000 ; free physical = 24076 ; free virtual = 29426
INFO: [v++ 60-1443] [14:29:09] Run run_link: Step vpl: Started
INFO: [v++ 60-1453] Command Line: vpl -t hw -f /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm -s --remote_ip_cache /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/ip_cache --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --log_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link --report_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/vplConfig.ini -k /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat --webtalk_flag Vitis --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link --no-info --iprepo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xo/ip_repo/xilinx_com_RTLKernel_DPUCZDX8G_1_0 --messageDb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link/vpl.pb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/dr.bd.tcl
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link

****** vpl v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [VPL 60-839] Read in kernel information from file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat'.
INFO: [VPL 60-423]   Target device: kv260_ppse_custom
INFO: [VPL 60-1032] Extracting hardware platform to /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/.local/hw_platform
[14:29:14] Run vpl: Step create_project: Started
Creating Vivado project.
[14:29:19] Run vpl: Step create_project: Completed
[14:29:19] Run vpl: Step create_bd: Started
[14:29:23] Run vpl: Step create_bd: Completed
[14:29:23] Run vpl: Step update_bd: Started
[14:29:23] Run vpl: Step update_bd: Completed
[14:29:23] Run vpl: Step generate_target: Started
[14:29:45] Run vpl: Step generate_target: Completed
[14:29:45] Run vpl: Step config_hw_runs: Started
[14:29:47] Run vpl: Step config_hw_runs: Completed
[14:29:47] Run vpl: Step synth: Started
[14:30:17] Block-level synthesis in progress, 0 of 6 jobs complete, 6 jobs running.
[14:30:48] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:31:18] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:31:48] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:32:18] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:32:48] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:33:18] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:33:48] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:34:18] Top-level synthesis in progress.
[14:34:47] Run vpl: Step synth: Completed
[14:34:47] Run vpl: Step impl: Started
[14:36:12] Finished 2nd of 6 tasks (FPGA linking synthesized kernels to platform). Elapsed time: 00h 07m 02s 

[14:36:12] Starting logic optimization..
[14:36:12] Phase 1 Retarget
[14:36:12] Phase 2 Constant propagation
[14:36:12] Phase 3 Sweep
[14:36:12] Phase 4 BUFG optimization
[14:36:12] Phase 5 Shift Register Optimization
[14:36:12] Phase 6 Post Processing Netlist
[14:36:12] Run vpl: Step impl: Failed
[14:36:12] Run vpl: FINISHED. Run Status: impl ERROR
ERROR: [VPL 60-773] In '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/vivado.log', caught Tcl error:  problem implementing dynamic region, impl_1: opt_design ERROR, please look at the run log file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/prj/prj.runs/impl_1/runme.log' for more information
ERROR: [VPL 60-777] Sorry, but it appears that a Xilinx program has terminated unexpectedly. Please contact Xilinx technical support for further assistance and give them the contents of the CrashLog directory in /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link
WARNING: [VPL 60-732] Link warning: No monitor points found for BD automation.
ERROR: [VPL 60-704] Integration error, problem implementing dynamic region, impl_1: opt_design ERROR, please look at the run log file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/prj/prj.runs/impl_1/runme.log' for more information
ERROR: [VPL 60-1328] Vpl run 'vpl' failed
ERROR: [VPL 60-806] Failed to finish platform linker
INFO: [v++ 60-1442] [14:36:12] Run run_link: Step vpl: Failed
Time (s): cpu = 00:00:02 ; elapsed = 00:07:03 . Memory (MB): peak = 458.402 ; gain = 0.000 ; free physical = 22875 ; free virtual = 28662
ERROR: [v++ 60-661] v++ link run 'run_link' failed
ERROR: [v++ 60-626] Kernel link failed to complete
ERROR: [v++ 60-703] Failed to finish linking
INFO: [v++ 60-1653] Closing dispatch client.
make: *** [Makefile:108: binary_container_1/binary_container_1.xclbin] Error 1
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ vivado

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

start_gui
Gtk-Message: 14:41:53.830: Failed to load module "canberra-gtk-module"
INFO: [Common 17-206] Exiting Vivado at Mon Jun 10 14:50:05 2024...
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make cleanr
make: *** No rule to make target 'cleanr'.  Stop.
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make clean
rm -f *.o *.elf *.log *.jou sample* v++* *.xclbin *.xclbin*
rm -rf binary_container_1/ packaged_*/ tmp_*/ .Xil/ _x/
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make all KERNEL=DPU DEVICE=KV260
/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/bin/vivado -mode batch -source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace -tclargs binary_container_1/dpu.xo DPUCZDX8G hw KV260

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

WARNING: [Runs 36-547] User Strategy 'Performance_Explore' from file '/home/logictronix03/.Xilinx/Vivado/2022.2/strategies/Performance_Explore.Vivado Implementation 2022.psg' discarded because strategy with same name already parsed from '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/strategies/VDI2022.psg'
source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace
binary_container_1/dpu.xo
INFO: [IP_Flow 19-5654] Module 'DPUCZDX8G' uses SystemVerilog sources with a Verilog top file. These SystemVerilog files will not be analysed by the packager.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_def.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagesynthesis.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagebehavioralsimulation.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_para.vh" from the top-level HDL file.
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_GP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP2' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'S_AXI_CONTROL' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'interrupt' of definition 'xilinx.com:signal:interrupt:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-4728] Bus Interface 'interrupt': Added interface parameter 'SENSITIVITY' with value 'LEVEL_HIGH'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_BUSIF' with value 'M_AXI_GP0'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_RESET' with value 'aresetn'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_clk_2': Added interface parameter 'ASSOCIATED_RESET' with value 'ap_rst_n_2'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_rst_n_2': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
INFO: [IP_Flow 19-4728] Bus Interface 'aresetn': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
WARNING: [IP_Flow 19-5661] Bus Interface 'ap_clk_2' does not have any bus interfaces associated with it.
WARNING: [IP_Flow 19-3157] Bus Interface 'ap_rst_n_2': Bus parameter POLARITY is ACTIVE_LOW but port 'ap_rst_n_2' is not *resetn - please double check the POLARITY setting.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagesynthesis (Synthesis)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Synthesis file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Synthesis'.
Resolution: Remove the file from the specified file group.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagebehavioralsimulation (Simulation)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Simulation file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Simulation'.
Resolution: Remove the file from the specified file group.
INFO: [IP_Flow 19-2181] Payment Required is not set for this core.
INFO: [IP_Flow 19-2187] The Product Guide file is missing.
INFO: [IP_Flow 19-795] Syncing license key meta-data
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from TCL Argument).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from TCL Argument).
WARNING: [Vivado 12-4404] The CPU emulation flow in v++ is only supported when using a packaged XO file that contains C-model files, none were found.
INFO: [Common 17-206] Exiting Vivado at Mon Jun 10 14:51:46 2024...
v++ -t hw --platform /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --save-temps --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/config_file/prj_config_1dpu --xp param:compiler.userPostSysLinkOverlayTcl=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/syslink/strip_interconnects.tcl  -l --temp_dir binary_container_1 --log_dir binary_container_1/logs --remote_ip_cache binary_container_1/ip_cache -o "binary_container_1/binary_container_1.xclbin" binary_container_1/dpu.xo
WARNING: [v++ 60-1600] The option 'xp' was used directly on the command line, where its usage is deprecated. To ensure input line works for supported operating systems or shells, v++ supports specification for some options in a configuration file. As an alternative, please use options 'advanced.*', 'vivado.*' in a configuration file. Use one or more configuration files along with section headers to define key-value pairs for the advanced properties or parameters. Specify a configuration file using '--config'.
INFO: [v++ 82-185] Check out the auto-generated 'sample_link.ini' configuration file. The file shows how to migrate from deprecated command line --xp switches to configuration file directives.
Option Map File Used: '/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/data/vitis/vpp/optMap.xml'

****** v++ v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [v++ 60-1306] Additional information associated with this v++ link can be found at:
	Reports: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link
	Log files: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link
Running Dispatch Server on port: 43243
INFO: [v++ 60-1548] Creating build summary session with primary output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.link_summary, at Mon Jun 10 14:52:00 2024
INFO: [v++ 60-1315] Creating rulecheck session with output '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/v++_link_binary_container_1_guidance.html', at Mon Jun 10 14:52:00 2024
INFO: [v++ 60-895]   Target platform: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm
INFO: [v++ 60-1578]   This platform contains Xilinx Shell Archive '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/hw/kv260_ppse_hardware_platform.xsa'
INFO: [v++ 60-629] Linking for hardware target
INFO: [v++ 60-423]   Target device: kv260_ppse_custom
INFO: [v++ 60-1332] Run 'run_link' status: Not started
INFO: [v++ 60-1443] [14:52:01] Run run_link: Step system_link: Started
INFO: [v++ 60-1453] Command Line: system_link --xo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo -keep --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/syslinkConfig.ini --xpfm /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --target hw --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [SYSTEM_LINK 82-70] Extracting xo v3 file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo
INFO: [SYSTEM_LINK 82-53] Creating IP database /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-38] [14:52:02] build_xd_ip_db started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/build_xd_ip_db -ip_search 0  -sds-pf /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/kv260_ppse_hardware_platform.hpfm -clkid 1 -ip /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/iprepo/xilinx_com_RTLKernel_DPUCZDX8G_1_0,DPUCZDX8G -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-37] [14:52:04] build_xd_ip_db finished successfully
Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 23458 ; free virtual = 29264
INFO: [SYSTEM_LINK 82-51] Create system connectivity graph
INFO: [SYSTEM_LINK 82-102] Applying explicit connections to the system connectivity graph: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [SYSTEM_LINK 82-38] [14:52:04] cfgen started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cfgen  -sp DPUCZDX8G_1.M_AXI_GP0:HPC1 -sp DPUCZDX8G_1.M_AXI_HP0:HP0 -sp DPUCZDX8G_1.M_AXI_HP2:HP1 -clock.freqHz 200000000:DPUCZDX8G_1.aclk -clock.freqHz 400000000:DPUCZDX8G_1.ap_clk_2 -dpa_mem_offload false -dmclkid 1 -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [CFGEN 83-0] Kernel Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G, num: 1  {DPUCZDX8G_1}
INFO: [CFGEN 83-0] Port Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_GP0, sptag: HPC1
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP0, sptag: HP0
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP2, sptag: HP1
INFO: [SYSTEM_LINK 82-37] [14:52:05] cfgen finished successfully
Time (s): cpu = 00:00:00.66 ; elapsed = 00:00:00.69 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 23461 ; free virtual = 29268
INFO: [SYSTEM_LINK 82-52] Create top-level block diagram
INFO: [SYSTEM_LINK 82-38] [14:52:05] cf2bd started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cf2bd  --linux --trace_buffer 1024 --input_file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml --ip_db /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml --cf_name dr --working_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int
INFO: [CF2BD 82-31] Launching cf2xd: cf2xd -linux -trace-buffer 1024 -i /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o dr.xml
INFO: [CF2BD 82-28] cf2xd finished successfully
INFO: [CF2BD 82-31] Launching cf_xsd: cf_xsd -disable-address-gen -dn dr -dp /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd
INFO: [CF2BD 82-28] cf_xsd finished successfully
INFO: [SYSTEM_LINK 82-37] [14:52:06] cf2bd finished successfully
Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 23479 ; free virtual = 29296
INFO: [v++ 60-1441] [14:52:06] Run run_link: Step system_link: Completed
Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 23531 ; free virtual = 29349
INFO: [v++ 60-1443] [14:52:06] Run run_link: Step cf2sw: Started
INFO: [v++ 60-1453] Command Line: cf2sw -sdsl /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/sdsl.dat -rtd /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw.rtd -nofilter /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw_full.rtd -xclbin /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.1.xml
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [14:52:07] Run run_link: Step cf2sw: Completed
Time (s): cpu = 00:00:00.9 ; elapsed = 00:00:00.93 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 23530 ; free virtual = 29349
INFO: [v++ 60-1443] [14:52:07] Run run_link: Step rtd2_system_diagram: Started
INFO: [v++ 60-1453] Command Line: rtd2SystemDiagram
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [14:52:07] Run run_link: Step rtd2_system_diagram: Completed
Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.04 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 23530 ; free virtual = 29348
INFO: [v++ 60-1443] [14:52:07] Run run_link: Step vpl: Started
INFO: [v++ 60-1453] Command Line: vpl -t hw -f /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm -s --remote_ip_cache /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/ip_cache --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --log_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link --report_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/vplConfig.ini -k /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat --webtalk_flag Vitis --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link --no-info --iprepo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xo/ip_repo/xilinx_com_RTLKernel_DPUCZDX8G_1_0 --messageDb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link/vpl.pb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/dr.bd.tcl
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link

****** vpl v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [VPL 60-839] Read in kernel information from file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat'.
INFO: [VPL 60-423]   Target device: kv260_ppse_custom
INFO: [VPL 60-1032] Extracting hardware platform to /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/.local/hw_platform
[14:52:12] Run vpl: Step create_project: Started
Creating Vivado project.
[14:52:17] Run vpl: Step create_project: Completed
[14:52:17] Run vpl: Step create_bd: Started
[14:52:21] Run vpl: Step create_bd: Completed
[14:52:21] Run vpl: Step update_bd: Started
[14:52:21] Run vpl: Step update_bd: Completed
[14:52:21] Run vpl: Step generate_target: Started
[14:52:43] Run vpl: Step generate_target: Completed
[14:52:43] Run vpl: Step config_hw_runs: Started
[14:52:45] Run vpl: Step config_hw_runs: Completed
[14:52:45] Run vpl: Step synth: Started
[14:53:15] Block-level synthesis in progress, 0 of 6 jobs complete, 6 jobs running.
[14:53:46] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:54:16] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:54:46] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:55:16] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:55:46] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:56:16] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[14:56:46] Top-level synthesis in progress.
[14:56:59] Run vpl: Step synth: Completed
[14:56:59] Run vpl: Step impl: Started
[14:58:00] Finished 2nd of 6 tasks (FPGA linking synthesized kernels to platform). Elapsed time: 00h 05m 51s 

[14:58:00] Starting logic optimization..
[14:58:19] Finished 3rd of 6 tasks (FPGA logic optimization). Elapsed time: 00h 00m 18s 

[14:58:19] Starting logic placement..
[14:58:19] Phase 1 Retarget
[14:58:19] Phase 2 Constant propagation
[14:58:19] Phase 3 Sweep
[14:58:19] Phase 4 BUFG optimization
[14:58:19] Phase 5 Shift Register Optimization
[14:58:19] Phase 6 Post Processing Netlist
[14:58:18] Run vpl: Step impl: Failed
[14:58:19] Run vpl: FINISHED. Run Status: impl ERROR

===>The following messages were generated while processing /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/prj/prj.runs/impl_1 :
ERROR: [VPL UTLZ-1] Resource utilization: RAMB18 and RAMB36/FIFO over-utilized in Top Level Design (This design requires more RAMB18 and RAMB36/FIFO cells than are available in the target device. This design requires 516 of such cell types but only 288 compatible sites are available in the target device. Please analyze your synthesis results and constraints to ensure the design is mapped to Xilinx primitives as expected. If so, please consider targeting a larger device.)
ERROR: [VPL UTLZ-1] Resource utilization: RAMB36/FIFO over-utilized in Top Level Design (This design requires more RAMB36/FIFO cells than are available in the target device. This design requires 240 of such cell types but only 144 compatible sites are available in the target device. Please analyze your synthesis results and constraints to ensure the design is mapped to Xilinx primitives as expected. If so, please consider targeting a larger device.)
ERROR: [VPL UTLZ-1] Resource utilization: RAMB36E2 over-utilized in Top Level Design (This design requires more RAMB36E2 cells than are available in the target device. This design requires 240 of such cell types but only 144 compatible sites are available in the target device. Please analyze your synthesis results and constraints to ensure the design is mapped to Xilinx primitives as expected. If so, please consider targeting a larger device.)
ERROR: [VPL 4-23] Error(s) found during DRC. Placer not run.
ERROR: [VPL 60-773] In '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/vivado.log', caught Tcl error:  problem implementing dynamic region, impl_1: place_design ERROR, please look at the run log file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/prj/prj.runs/impl_1/runme.log' for more information
WARNING: [VPL 60-732] Link warning: No monitor points found for BD automation.
ERROR: [VPL 60-704] Integration error, problem implementing dynamic region, impl_1: place_design ERROR, please look at the run log file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/prj/prj.runs/impl_1/runme.log' for more information
ERROR: [VPL 60-1328] Vpl run 'vpl' failed
ERROR: [VPL 60-806] Failed to finish platform linker
INFO: [v++ 60-1442] [14:58:19] Run run_link: Step vpl: Failed
Time (s): cpu = 00:00:03 ; elapsed = 00:06:12 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 19433 ; free virtual = 25657
ERROR: [v++ 60-661] v++ link run 'run_link' failed
ERROR: [v++ 60-626] Kernel link failed to complete
ERROR: [v++ 60-703] Failed to finish linking
INFO: [v++ 60-1653] Closing dispatch client.
make: *** [Makefile:108: binary_container_1/binary_container_1.xclbin] Error 1
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make clean
rm -f *.o *.elf *.log *.jou sample* v++* *.xclbin *.xclbin*
rm -rf binary_container_1/ packaged_*/ tmp_*/ .Xil/ _x/
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make all KERNEL=DPU DEVICE=KV260
/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/bin/vivado -mode batch -source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace -tclargs binary_container_1/dpu.xo DPUCZDX8G hw KV260

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

WARNING: [Runs 36-547] User Strategy 'Performance_Explore' from file '/home/logictronix03/.Xilinx/Vivado/2022.2/strategies/Performance_Explore.Vivado Implementation 2022.psg' discarded because strategy with same name already parsed from '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/strategies/VDI2022.psg'
source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace
binary_container_1/dpu.xo
INFO: [IP_Flow 19-5654] Module 'DPUCZDX8G' uses SystemVerilog sources with a Verilog top file. These SystemVerilog files will not be analysed by the packager.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_def.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagesynthesis.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagebehavioralsimulation.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_para.vh" from the top-level HDL file.
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_GP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP2' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'S_AXI_CONTROL' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'interrupt' of definition 'xilinx.com:signal:interrupt:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-4728] Bus Interface 'interrupt': Added interface parameter 'SENSITIVITY' with value 'LEVEL_HIGH'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_BUSIF' with value 'M_AXI_GP0'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_RESET' with value 'aresetn'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_clk_2': Added interface parameter 'ASSOCIATED_RESET' with value 'ap_rst_n_2'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_rst_n_2': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
INFO: [IP_Flow 19-4728] Bus Interface 'aresetn': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
WARNING: [IP_Flow 19-5661] Bus Interface 'ap_clk_2' does not have any bus interfaces associated with it.
WARNING: [IP_Flow 19-3157] Bus Interface 'ap_rst_n_2': Bus parameter POLARITY is ACTIVE_LOW but port 'ap_rst_n_2' is not *resetn - please double check the POLARITY setting.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagesynthesis (Synthesis)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Synthesis file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Synthesis'.
Resolution: Remove the file from the specified file group.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagebehavioralsimulation (Simulation)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Simulation file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Simulation'.
Resolution: Remove the file from the specified file group.
INFO: [IP_Flow 19-2181] Payment Required is not set for this core.
INFO: [IP_Flow 19-2187] The Product Guide file is missing.
INFO: [IP_Flow 19-795] Syncing license key meta-data
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from TCL Argument).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from TCL Argument).
WARNING: [Vivado 12-4404] The CPU emulation flow in v++ is only supported when using a packaged XO file that contains C-model files, none were found.
INFO: [Common 17-206] Exiting Vivado at Mon Jun 10 15:02:16 2024...
v++ -t hw --platform /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --save-temps --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/config_file/prj_config_1dpu --xp param:compiler.userPostSysLinkOverlayTcl=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/syslink/strip_interconnects.tcl  -l --temp_dir binary_container_1 --log_dir binary_container_1/logs --remote_ip_cache binary_container_1/ip_cache -o "binary_container_1/binary_container_1.xclbin" binary_container_1/dpu.xo
WARNING: [v++ 60-1600] The option 'xp' was used directly on the command line, where its usage is deprecated. To ensure input line works for supported operating systems or shells, v++ supports specification for some options in a configuration file. As an alternative, please use options 'advanced.*', 'vivado.*' in a configuration file. Use one or more configuration files along with section headers to define key-value pairs for the advanced properties or parameters. Specify a configuration file using '--config'.
INFO: [v++ 82-185] Check out the auto-generated 'sample_link.ini' configuration file. The file shows how to migrate from deprecated command line --xp switches to configuration file directives.
Option Map File Used: '/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/data/vitis/vpp/optMap.xml'

****** v++ v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [v++ 60-1306] Additional information associated with this v++ link can be found at:
	Reports: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link
	Log files: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link
Running Dispatch Server on port: 41505
INFO: [v++ 60-1548] Creating build summary session with primary output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.link_summary, at Mon Jun 10 15:02:30 2024
INFO: [v++ 60-1315] Creating rulecheck session with output '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/v++_link_binary_container_1_guidance.html', at Mon Jun 10 15:02:30 2024
INFO: [v++ 60-895]   Target platform: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm
INFO: [v++ 60-1578]   This platform contains Xilinx Shell Archive '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/hw/kv260_ppse_hardware_platform.xsa'
INFO: [v++ 60-629] Linking for hardware target
INFO: [v++ 60-423]   Target device: kv260_ppse_custom
INFO: [v++ 60-1332] Run 'run_link' status: Not started
INFO: [v++ 60-1443] [15:02:30] Run run_link: Step system_link: Started
INFO: [v++ 60-1453] Command Line: system_link --xo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo -keep --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/syslinkConfig.ini --xpfm /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --target hw --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [SYSTEM_LINK 82-70] Extracting xo v3 file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo
INFO: [SYSTEM_LINK 82-53] Creating IP database /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-38] [15:02:31] build_xd_ip_db started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/build_xd_ip_db -ip_search 0  -sds-pf /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/kv260_ppse_hardware_platform.hpfm -clkid 1 -ip /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/iprepo/xilinx_com_RTLKernel_DPUCZDX8G_1_0,DPUCZDX8G -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-37] [15:02:34] build_xd_ip_db finished successfully
Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 23404 ; free virtual = 29239
INFO: [SYSTEM_LINK 82-51] Create system connectivity graph
INFO: [SYSTEM_LINK 82-102] Applying explicit connections to the system connectivity graph: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [SYSTEM_LINK 82-38] [15:02:34] cfgen started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cfgen  -sp DPUCZDX8G_1.M_AXI_GP0:HPC1 -sp DPUCZDX8G_1.M_AXI_HP0:HP0 -sp DPUCZDX8G_1.M_AXI_HP2:HP1 -clock.freqHz 200000000:DPUCZDX8G_1.aclk -clock.freqHz 400000000:DPUCZDX8G_1.ap_clk_2 -dpa_mem_offload false -dmclkid 1 -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [CFGEN 83-0] Kernel Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G, num: 1  {DPUCZDX8G_1}
INFO: [CFGEN 83-0] Port Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_GP0, sptag: HPC1
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP0, sptag: HP0
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP2, sptag: HP1
INFO: [SYSTEM_LINK 82-37] [15:02:34] cfgen finished successfully
Time (s): cpu = 00:00:00.64 ; elapsed = 00:00:00.68 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 23398 ; free virtual = 29232
INFO: [SYSTEM_LINK 82-52] Create top-level block diagram
INFO: [SYSTEM_LINK 82-38] [15:02:34] cf2bd started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cf2bd  --linux --trace_buffer 1024 --input_file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml --ip_db /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml --cf_name dr --working_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int
INFO: [CF2BD 82-31] Launching cf2xd: cf2xd -linux -trace-buffer 1024 -i /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o dr.xml
INFO: [CF2BD 82-28] cf2xd finished successfully
INFO: [CF2BD 82-31] Launching cf_xsd: cf_xsd -disable-address-gen -dn dr -dp /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd
INFO: [CF2BD 82-28] cf_xsd finished successfully
INFO: [SYSTEM_LINK 82-37] [15:02:36] cf2bd finished successfully
Time (s): cpu = 00:00:00.98 ; elapsed = 00:00:01 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 23394 ; free virtual = 29232
INFO: [v++ 60-1441] [15:02:36] Run run_link: Step system_link: Completed
Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 23448 ; free virtual = 29286
INFO: [v++ 60-1443] [15:02:36] Run run_link: Step cf2sw: Started
INFO: [v++ 60-1453] Command Line: cf2sw -sdsl /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/sdsl.dat -rtd /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw.rtd -nofilter /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw_full.rtd -xclbin /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.1.xml
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [15:02:36] Run run_link: Step cf2sw: Completed
Time (s): cpu = 00:00:00.89 ; elapsed = 00:00:00.91 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 23451 ; free virtual = 29290
INFO: [v++ 60-1443] [15:02:36] Run run_link: Step rtd2_system_diagram: Started
INFO: [v++ 60-1453] Command Line: rtd2SystemDiagram
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [15:02:36] Run run_link: Step rtd2_system_diagram: Completed
Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.05 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 23451 ; free virtual = 29290
INFO: [v++ 60-1443] [15:02:36] Run run_link: Step vpl: Started
INFO: [v++ 60-1453] Command Line: vpl -t hw -f /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm -s --remote_ip_cache /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/ip_cache --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --log_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link --report_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/vplConfig.ini -k /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat --webtalk_flag Vitis --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link --no-info --iprepo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xo/ip_repo/xilinx_com_RTLKernel_DPUCZDX8G_1_0 --messageDb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link/vpl.pb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/dr.bd.tcl
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link

****** vpl v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [VPL 60-839] Read in kernel information from file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat'.
INFO: [VPL 60-423]   Target device: kv260_ppse_custom
INFO: [VPL 60-1032] Extracting hardware platform to /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/.local/hw_platform
[15:02:41] Run vpl: Step create_project: Started
Creating Vivado project.
[15:02:46] Run vpl: Step create_project: Completed
[15:02:46] Run vpl: Step create_bd: Started
[15:02:50] Run vpl: Step create_bd: Completed
[15:02:50] Run vpl: Step update_bd: Started
[15:02:50] Run vpl: Step update_bd: Completed
[15:02:50] Run vpl: Step generate_target: Started
[15:03:12] Run vpl: Step generate_target: Completed
[15:03:12] Run vpl: Step config_hw_runs: Started
[15:03:13] Run vpl: Step config_hw_runs: Completed
[15:03:13] Run vpl: Step synth: Started
[15:03:44] Block-level synthesis in progress, 0 of 6 jobs complete, 6 jobs running.
[15:04:14] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[15:04:44] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[15:05:14] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[15:05:44] Top-level synthesis in progress.
[15:06:09] Run vpl: Step synth: Completed
[15:06:09] Run vpl: Step impl: Started
[15:07:09] Finished 3rd of 6 tasks (FPGA logic optimization). Elapsed time: 00h 04m 31s 

[15:07:09] Starting logic placement..
[15:07:09] Phase 1 Placer Initialization
[15:07:09] Phase 1.1 Placer Initialization Netlist Sorting
[15:07:09] Phase 1.2 IO Placement/ Clock Placement/ Build Placer Device
[15:07:09] Finished 2nd of 6 tasks (FPGA linking synthesized kernels to platform). Elapsed time: 00h 00m 00s 

[15:07:09] Starting logic optimization..
[15:07:09] Phase 1 Retarget
[15:07:09] Phase 2 Constant propagation
[15:07:09] Phase 3 Sweep
[15:07:09] Phase 4 BUFG optimization
[15:07:09] Phase 5 Shift Register Optimization
[15:07:09] Phase 6 Post Processing Netlist
[15:07:39] Phase 1.3 Build Placer Netlist Model
[15:07:39] Phase 1.4 Constrain Clocks/Macros
[15:07:39] Phase 2 Global Placement
[15:07:39] Phase 2.1 Floorplanning
[15:07:39] Phase 2.1.1 Partition Driven Placement
[15:07:39] Phase 2.1.1.1 PBP: Partition Driven Placement
[15:07:39] Phase 2.1.1.2 PBP: Clock Region Placement
[15:07:39] Phase 2.1.1.3 PBP: Discrete Incremental
[15:07:39] Phase 2.1.1.4 PBP: Compute Congestion
[15:07:39] Phase 2.1.1.5 PBP: Macro Placement
[15:07:39] Phase 2.1.1.6 PBP: UpdateTiming
[15:07:39] Phase 2.1.1.7 PBP: Add part constraints
[15:07:39] Phase 2.2 Update Timing before SLR Path Opt
[15:07:39] Phase 2.3 Post-Processing in Floorplanning
[15:07:39] Phase 2.4 Global Placement Core
[15:08:09] Phase 2.4.1 UpdateTiming Before Physical Synthesis
[15:08:09] Phase 2.4.2 Physical Synthesis In Placer
[15:08:09] Phase 3 Detail Placement
[15:08:09] Phase 3.1 Commit Multi Column Macros
[15:08:09] Phase 3.2 Commit Most Macros & LUTRAMs
[15:08:09] Phase 3.3 Small Shape DP
[15:08:09] Phase 3.3.1 Small Shape Clustering
[15:08:09] Phase 3.3.2 Flow Legalize Slice Clusters
[15:08:09] Phase 3.3.3 Slice Area Swap
[15:08:09] Phase 3.3.3.1 Slice Area Swap Initial
[15:08:39] Phase 3.4 Re-assign LUT pins
[15:08:39] Phase 3.5 Pipeline Register Optimization
[15:08:39] Phase 4 Post Placement Optimization and Clean-Up
[15:08:39] Phase 4.1 Post Commit Optimization
[15:08:39] Phase 4.1.1 Post Placement Optimization
[15:08:39] Phase 4.1.1.1 BUFG Insertion
[15:08:39] Phase 1 Physical Synthesis Initialization
[15:08:39] Phase 4.1.1.2 Post Placement Timing Optimization
[15:08:39] Phase 4.2 Post Placement Cleanup
[15:08:39] Phase 4.3 Placer Reporting
[15:08:39] Phase 4.3.1 Print Estimated Congestion
[15:08:39] Phase 4.4 Final Placement Cleanup
[15:08:39] Finished 4th of 6 tasks (FPGA logic placement). Elapsed time: 00h 01m 30s 

[15:08:39] Starting logic routing..
[15:08:39] Phase 1 Build RT Design
[15:09:09] Phase 2 Router Initialization
[15:09:09] Phase 2.1 Fix Topology Constraints
[15:09:09] Phase 2.2 Pre Route Cleanup
[15:09:09] Phase 2.3 Global Clock Net Routing
[15:09:09] Phase 2.4 Update Timing
[15:09:09] Phase 2.5 Update Timing for Bus Skew
[15:09:09] Phase 2.5.1 Update Timing
[15:09:09] Phase 3 Initial Routing
[15:09:09] Phase 3.1 Global Routing
[15:09:09] Phase 4 Rip-up And Reroute
[15:09:09] Phase 4.1 Global Iteration 0
[15:10:39] Phase 4.2 Additional Iteration for Hold
[15:10:39] Phase 5 Delay and Skew Optimization
[15:10:39] Phase 5.1 Delay CleanUp
[15:10:39] Phase 5.1.1 Update Timing
[15:10:39] Phase 5.1.2 Update Timing
[15:10:39] Phase 5.2 Clock Skew Optimization
[15:10:39] Phase 6 Post Hold Fix
[15:10:39] Phase 6.1 Hold Fix Iter
[15:10:39] Phase 6.1.1 Update Timing
[15:10:39] Phase 7 Route finalize
[15:10:39] Phase 8 Verifying routed nets
[15:10:39] Phase 9 Depositing Routes
[15:10:39] Phase 10 Resolve XTalk
[15:10:39] Phase 11 Route finalize
[15:10:39] Phase 12 Post Router Timing
[15:10:39] Finished 5th of 6 tasks (FPGA routing). Elapsed time: 00h 02m 00s 

[15:10:39] Starting bitstream generation..
[15:11:07] Creating bitmap...
[15:11:07] Writing bitstream ./kv260_top_wrapper.bit...
[15:11:07] Finished 6th of 6 tasks (FPGA bitstream generation). Elapsed time: 00h 00m 27s 
Check VPL, containing 1 checks, has run: 0 errors
[15:11:07] Run vpl: Step impl: Completed
[15:11:07] Run vpl: FINISHED. Run Status: impl Complete!
INFO: [v++ 60-1441] [15:11:07] Run run_link: Step vpl: Completed
Time (s): cpu = 00:00:03 ; elapsed = 00:08:30 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 22202 ; free virtual = 28485
INFO: [v++ 60-1443] [15:11:07] Run run_link: Step rtdgen: Started
INFO: [v++ 60-1453] Command Line: rtdgen
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1453] Command Line: cf2sw -a /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/address_map.xml -sdsl /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/sdsl.dat -xclbin /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.xml -rtd /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.rtd -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.xml
INFO: [v++ 60-1652] Cf2sw returned exit code: 0
INFO: [v++ 60-1441] [15:11:08] Run run_link: Step rtdgen: Completed
Time (s): cpu = 00:00:00.85 ; elapsed = 00:00:00.91 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 22197 ; free virtual = 28481
INFO: [v++ 60-1443] [15:11:08] Run run_link: Step xclbinutil: Started
INFO: [v++ 60-1453] Command Line: xclbinutil --add-section BITSTREAM:RAW:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/system.bit --force --target hw --key-value SYS:dfx_enable:false --add-section :JSON:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.rtd --add-section CLOCK_FREQ_TOPOLOGY:JSON:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_xml.rtd --add-section BUILD_METADATA:JSON:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_build.rtd --add-section EMBEDDED_METADATA:RAW:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.xml --add-section SYSTEM_METADATA:RAW:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/systemDiagramModelSlrBaseAddress.json --key-value SYS:PlatformVBNV:xilinx_kv260_kv260_ppse_hardware_platform_0_0 --output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
XRT Build Version: 2.14.0 (2022.2)
       Build Date: 2024-01-31 18:32:12
          Hash ID: ae8692307adbc1283c67edcc3a220f83b6ad34d9
Creating a default 'in-memory' xclbin image.

Section: 'BITSTREAM'(0) was successfully added.
Size   : 7797813 bytes
Format : RAW
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/system.bit'

Section: 'MEM_TOPOLOGY'(6) was successfully added.
Format : JSON
File   : 'mem_topology'

Section: 'IP_LAYOUT'(8) was successfully added.
Format : JSON
File   : 'ip_layout'

Section: 'CONNECTIVITY'(7) was successfully added.
Format : JSON
File   : 'connectivity'
WARNING: Skipping CLOCK_FREQ_TOPOLOGY section for count size is zero.
WARNING: Section 'CLOCK_FREQ_TOPOLOGY' content is empty.  No data in the given JSON file.

Section: 'CLOCK_FREQ_TOPOLOGY'(11) was empty.  No action taken.
Format : JSON
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_xml.rtd'

Section: 'BUILD_METADATA'(14) was successfully added.
Size   : 4813 bytes
Format : JSON
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_build.rtd'

Section: 'EMBEDDED_METADATA'(2) was successfully added.
Size   : 4580 bytes
Format : RAW
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.xml'

Section: 'SYSTEM_METADATA'(22) was successfully added.
Size   : 19960 bytes
Format : RAW
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/systemDiagramModelSlrBaseAddress.json'
Successfully wrote (7838627 bytes) to the output file: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin
Leaving xclbinutil.
INFO: [v++ 60-1441] [15:11:08] Run run_link: Step xclbinutil: Completed
Time (s): cpu = 00:00:00.06 ; elapsed = 00:00:00.07 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 22199 ; free virtual = 28492
INFO: [v++ 60-1443] [15:11:08] Run run_link: Step xclbinutilinfo: Started
INFO: [v++ 60-1453] Command Line: xclbinutil --quiet --force --info /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.info --input /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [15:11:08] Run run_link: Step xclbinutilinfo: Completed
Time (s): cpu = 00:00:00.08 ; elapsed = 00:00:00.1 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 22192 ; free virtual = 28485
INFO: [v++ 60-1443] [15:11:08] Run run_link: Step generate_sc_driver: Started
INFO: [v++ 60-1453] Command Line: 
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [15:11:08] Run run_link: Step generate_sc_driver: Completed
Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 22192 ; free virtual = 28485
Check POST-VPL, containing 1 checks, has run: 0 errors
INFO: [v++ 60-244] Generating system estimate report...
INFO: [v++ 60-1092] Generated system estimate report: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/system_estimate_binary_container_1.xtxt
INFO: [v++ 60-2397] Platform default or user specified output type sd_card detected but is not a supported output for v++ --link. Use the v++ --package option instead to create SD card output.
INFO: [v++ 60-586] Created binary_container_1/binary_container_1.xclbin
INFO: [v++ 60-1307] Run completed. Additional information can be found in:
	Guidance: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/v++_link_binary_container_1_guidance.html
	Timing Report: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/imp/impl_1_kv260_top_wrapper_timing_summary_routed.rpt
	Vivado Log: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link/vivado.log
	Steps Log File: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link/link.steps.log

INFO: [v++ 60-2343] Use the vitis_analyzer tool to visualize and navigate the relevant reports. Run the following command. 
    vitis_analyzer /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.link_summary 
INFO: [v++ 60-791] Total elapsed time: 0h 8m 48s
INFO: [v++ 60-1653] Closing dispatch client.
v++ -t hw --platform /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm -p binary_container_1/binary_container_1.xclbin -o binary_container_1/dpu.xclbin --package.out_dir binary_container_1 --package.rootfs /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260_vitis_platform/xilinx-zynqmp-common-v2022.2/rootfs.ext4 --package.sd_file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260_vitis_platform/xilinx-zynqmp-common-v2022.2/Image 
Option Map File Used: '/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/data/vitis/vpp/optMap.xml'

****** v++ v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [v++ 60-1306] Additional information associated with this v++ package can be found at:
	Reports: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/_x/reports/package
	Log files: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/_x/logs/package
Running Dispatch Server on port: 41193
INFO: [v++ 60-1548] Creating build summary session with primary output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xclbin.package_summary, at Mon Jun 10 15:11:29 2024
INFO: [v++ 60-1315] Creating rulecheck session with output '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/_x/reports/package/v++_package_dpu_guidance.html', at Mon Jun 10 15:11:29 2024
INFO: [v++ 60-895]   Target platform: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm
INFO: [v++ 60-1578]   This platform contains Xilinx Shell Archive '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/hw/kv260_ppse_hardware_platform.xsa'
INFO: [v++ 60-2256] Packaging for hardware
INFO: [#UNDEF] For Kria SOM platform, v++ package does not support SD card generation, and no files will be generated
INFO: [v++ 60-2343] Use the vitis_analyzer tool to visualize and navigate the relevant reports. Run the following command. 
    vitis_analyzer /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xclbin.package_summary 
INFO: [v++ 60-791] Total elapsed time: 0h 0m 10s
INFO: [v++ 60-1653] Closing dispatch client.
cp ./binary_*/link/vivado/vpl/prj/prj*/sources_1/bd/*/hw_handoff/*.hwh ./binary_*/sd_card
cp: cannot create regular file './binary_*/sd_card': No such file or directory
make: *** [Makefile:112: package] Error 1
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ vivado

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

WARNING: [Runs 36-547] User Strategy 'Performance_Explore' from file '/home/logictronix03/.Xilinx/Vivado/2022.2/strategies/Performance_Explore.Vivado Implementation 2022.psg' discarded because strategy with same name already parsed from '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/strategies/VDI2022.psg'
start_gui
Gtk-Message: 16:20:03.275: Failed to load module "canberra-gtk-module"
Terminated
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ vivado

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

WARNING: [Runs 36-547] User Strategy 'Performance_Explore' from file '/home/logictronix03/.Xilinx/Vivado/2022.2/strategies/Performance_Explore.Vivado Implementation 2022.psg' discarded because strategy with same name already parsed from '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/strategies/VDI2022.psg'
start_gui
Gtk-Message: 16:23:26.295: Failed to load module "canberra-gtk-module"
Terminated
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make clean
rm -f *.o *.elf *.log *.jou sample* v++* *.xclbin *.xclbin*
rm -rf binary_container_1/ packaged_*/ tmp_*/ .Xil/ _x/
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ make all KERNEL=DPU DEVICE=KV260
/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/bin/vivado -mode batch -source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace -tclargs binary_container_1/dpu.xo DPUCZDX8G hw KV260

****** Vivado v2022.2 (64-bit)
  **** SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
  **** IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

WARNING: [Runs 36-547] User Strategy 'Performance_Explore' from file '/home/logictronix03/.Xilinx/Vivado/2022.2/strategies/Performance_Explore.Vivado Implementation 2022.psg' discarded because strategy with same name already parsed from '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/strategies/VDI2022.psg'
source /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/scripts/gen_dpu_xo.tcl -notrace
binary_container_1/dpu.xo
INFO: [IP_Flow 19-5654] Module 'DPUCZDX8G' uses SystemVerilog sources with a Verilog top file. These SystemVerilog files will not be analysed by the packager.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_def.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" from the top-level HDL file.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagesynthesis.
INFO: [IP_Flow 19-1841] HDL Parser: Add include file "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" to file group xilinx_anylanguagebehavioralsimulation.
INFO: [IP_Flow 19-1842] HDL Parser: Found include file "src/arch_para.vh" from the top-level HDL file.
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aclk' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from X_INTERFACE_INFO parameter from HDL file).
INFO: [IP_Flow 19-5107] Inferred bus interface 'aresetn' of definition 'xilinx.com:signal:reset:1.0' (from 'X_INTERFACE_INFO' attribute).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_GP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP0' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'M_AXI_HP2' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'S_AXI_CONTROL' of definition 'xilinx.com:interface:aximm:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-5107] Inferred bus interface 'interrupt' of definition 'xilinx.com:signal:interrupt:1.0' (from Xilinx Repository).
INFO: [IP_Flow 19-4728] Bus Interface 'interrupt': Added interface parameter 'SENSITIVITY' with value 'LEVEL_HIGH'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_BUSIF' with value 'M_AXI_GP0'.
INFO: [IP_Flow 19-4728] Bus Interface 'aclk': Added interface parameter 'ASSOCIATED_RESET' with value 'aresetn'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_clk_2': Added interface parameter 'ASSOCIATED_RESET' with value 'ap_rst_n_2'.
INFO: [IP_Flow 19-4728] Bus Interface 'ap_rst_n_2': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
INFO: [IP_Flow 19-4728] Bus Interface 'aresetn': Added interface parameter 'POLARITY' with value 'ACTIVE_LOW'.
WARNING: [IP_Flow 19-5661] Bus Interface 'ap_clk_2' does not have any bus interfaces associated with it.
WARNING: [IP_Flow 19-3157] Bus Interface 'ap_rst_n_2': Bus parameter POLARITY is ACTIVE_LOW but port 'ap_rst_n_2' is not *resetn - please double check the POLARITY setting.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagesynthesis (Synthesis)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Synthesis file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Synthesis'.
Resolution: Remove the file from the specified file group.
WARNING: [IP_Flow 19-731] File Group 'xilinx_anylanguagebehavioralsimulation (Simulation)': "/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh" file path is not relative to the IP root directory.
WARNING: [IP_Flow 19-4816] The Simulation file group has two include files that have the same base name. It is not guaranteed which of these two files will be picked up during synthesis/simulation:   src/dpu_conf.vh
  /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/dpu_conf.vh
WARNING: [IP_Flow 19-991] Unrecognized or unsupported file 'src/fingerprint_json.ttcl' found in file group 'Simulation'.
Resolution: Remove the file from the specified file group.
INFO: [IP_Flow 19-2181] Payment Required is not set for this core.
INFO: [IP_Flow 19-2187] The Product Guide file is missing.
INFO: [IP_Flow 19-795] Syncing license key meta-data
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/home/logictronix03/tools/Xilinx/2022_2/Vivado/2022.2/data/ip'.
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_clk_2' of definition 'xilinx.com:signal:clock:1.0' (from TCL Argument).
INFO: [IP_Flow 19-5107] Inferred bus interface 'ap_rst_n_2' of definition 'xilinx.com:signal:reset:1.0' (from TCL Argument).
WARNING: [Vivado 12-4404] The CPU emulation flow in v++ is only supported when using a packaged XO file that contains C-model files, none were found.
INFO: [Common 17-206] Exiting Vivado at Mon Jun 10 16:33:06 2024...
v++ -t hw --platform /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --save-temps --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/config_file/prj_config_1dpu --xp param:compiler.userPostSysLinkOverlayTcl=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/syslink/strip_interconnects.tcl  -l --temp_dir binary_container_1 --log_dir binary_container_1/logs --remote_ip_cache binary_container_1/ip_cache -o "binary_container_1/binary_container_1.xclbin" binary_container_1/dpu.xo
WARNING: [v++ 60-1600] The option 'xp' was used directly on the command line, where its usage is deprecated. To ensure input line works for supported operating systems or shells, v++ supports specification for some options in a configuration file. As an alternative, please use options 'advanced.*', 'vivado.*' in a configuration file. Use one or more configuration files along with section headers to define key-value pairs for the advanced properties or parameters. Specify a configuration file using '--config'.
INFO: [v++ 82-185] Check out the auto-generated 'sample_link.ini' configuration file. The file shows how to migrate from deprecated command line --xp switches to configuration file directives.
Option Map File Used: '/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/data/vitis/vpp/optMap.xml'

****** v++ v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [v++ 60-1306] Additional information associated with this v++ link can be found at:
	Reports: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link
	Log files: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link
Running Dispatch Server on port: 43825
INFO: [v++ 60-1548] Creating build summary session with primary output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.link_summary, at Mon Jun 10 16:33:20 2024
INFO: [v++ 60-1315] Creating rulecheck session with output '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/v++_link_binary_container_1_guidance.html', at Mon Jun 10 16:33:20 2024
INFO: [v++ 60-895]   Target platform: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm
INFO: [v++ 60-1578]   This platform contains Xilinx Shell Archive '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/hw/kv260_ppse_hardware_platform.xsa'
INFO: [v++ 60-629] Linking for hardware target
INFO: [v++ 60-423]   Target device: kv260_ppse_custom
INFO: [v++ 60-1332] Run 'run_link' status: Not started
INFO: [v++ 60-1443] [16:33:20] Run run_link: Step system_link: Started
INFO: [v++ 60-1453] Command Line: system_link --xo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo -keep --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/syslinkConfig.ini --xpfm /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm --target hw --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [SYSTEM_LINK 82-70] Extracting xo v3 file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xo
INFO: [SYSTEM_LINK 82-53] Creating IP database /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-38] [16:33:21] build_xd_ip_db started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/build_xd_ip_db -ip_search 0  -sds-pf /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/kv260_ppse_hardware_platform.hpfm -clkid 1 -ip /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/iprepo/xilinx_com_RTLKernel_DPUCZDX8G_1_0,DPUCZDX8G -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml
INFO: [SYSTEM_LINK 82-37] [16:33:24] build_xd_ip_db finished successfully
Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 19823 ; free virtual = 30177
INFO: [SYSTEM_LINK 82-51] Create system connectivity graph
INFO: [SYSTEM_LINK 82-102] Applying explicit connections to the system connectivity graph: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [SYSTEM_LINK 82-38] [16:33:24] cfgen started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cfgen  -sp DPUCZDX8G_1.M_AXI_GP0:HPC1 -sp DPUCZDX8G_1.M_AXI_HP0:HP0 -sp DPUCZDX8G_1.M_AXI_HP2:HP1 -clock.freqHz 200000000:DPUCZDX8G_1.aclk -clock.freqHz 400000000:DPUCZDX8G_1.ap_clk_2 -dpa_mem_offload false -dmclkid 1 -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml
INFO: [CFGEN 83-0] Kernel Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G, num: 1  {DPUCZDX8G_1}
INFO: [CFGEN 83-0] Port Specs: 
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_GP0, sptag: HPC1
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP0, sptag: HP0
INFO: [CFGEN 83-0]   kernel: DPUCZDX8G_1, k_port: M_AXI_HP2, sptag: HP1
INFO: [SYSTEM_LINK 82-37] [16:33:25] cfgen finished successfully
Time (s): cpu = 00:00:00.7 ; elapsed = 00:00:00.72 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 19830 ; free virtual = 30183
INFO: [SYSTEM_LINK 82-52] Create top-level block diagram
INFO: [SYSTEM_LINK 82-38] [16:33:25] cf2bd started: /home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/bin/cf2bd  --linux --trace_buffer 1024 --input_file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml --ip_db /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml --cf_name dr --working_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int
INFO: [CF2BD 82-31] Launching cf2xd: cf2xd -linux -trace-buffer 1024 -i /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/cfgraph/cfgen_cfgraph.xml -r /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.cdb/xd_ip_db.xml -o dr.xml
INFO: [CF2BD 82-28] cf2xd finished successfully
INFO: [CF2BD 82-31] Launching cf_xsd: cf_xsd -disable-address-gen -dn dr -dp /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/sys_link/_sysl/.xsd
INFO: [CF2BD 82-28] cf_xsd finished successfully
INFO: [SYSTEM_LINK 82-37] [16:33:26] cf2bd finished successfully
Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 441.539 ; gain = 0.000 ; free physical = 19828 ; free virtual = 30185
INFO: [v++ 60-1441] [16:33:26] Run run_link: Step system_link: Completed
Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 19885 ; free virtual = 30242
INFO: [v++ 60-1443] [16:33:26] Run run_link: Step cf2sw: Started
INFO: [v++ 60-1453] Command Line: cf2sw -sdsl /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/sdsl.dat -rtd /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw.rtd -nofilter /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/cf2sw_full.rtd -xclbin /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.xml -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.1.xml
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [16:33:27] Run run_link: Step cf2sw: Completed
Time (s): cpu = 00:00:00.89 ; elapsed = 00:00:00.94 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 19885 ; free virtual = 30243
INFO: [v++ 60-1443] [16:33:27] Run run_link: Step rtd2_system_diagram: Started
INFO: [v++ 60-1453] Command Line: rtd2SystemDiagram
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [16:33:27] Run run_link: Step rtd2_system_diagram: Completed
Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.05 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 19881 ; free virtual = 30239
INFO: [v++ 60-1443] [16:33:27] Run run_link: Step vpl: Started
INFO: [v++ 60-1453] Command Line: vpl -t hw -f /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm -s --remote_ip_cache /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/ip_cache --output_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int --log_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link --report_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link --config /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/vplConfig.ini -k /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat --webtalk_flag Vitis --temp_dir /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link --no-info --iprepo /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xo/ip_repo/xilinx_com_RTLKernel_DPUCZDX8G_1_0 --messageDb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link/vpl.pb /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/dr.bd.tcl
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link

****** vpl v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [VPL 60-839] Read in kernel information from file '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/kernel_info.dat'.
INFO: [VPL 60-423]   Target device: kv260_ppse_custom
INFO: [VPL 60-1032] Extracting hardware platform to /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/vivado/vpl/.local/hw_platform
[16:33:31] Run vpl: Step create_project: Started
Creating Vivado project.
[16:33:36] Run vpl: Step create_project: Completed
[16:33:36] Run vpl: Step create_bd: Started
[16:33:40] Run vpl: Step create_bd: Completed
[16:33:40] Run vpl: Step update_bd: Started
[16:33:40] Run vpl: Step update_bd: Completed
[16:33:40] Run vpl: Step generate_target: Started
[16:34:01] Run vpl: Step generate_target: Completed
[16:34:01] Run vpl: Step config_hw_runs: Started
[16:34:03] Run vpl: Step config_hw_runs: Completed
[16:34:03] Run vpl: Step synth: Started
[16:34:34] Block-level synthesis in progress, 0 of 6 jobs complete, 6 jobs running.
[16:35:04] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:35:34] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:36:04] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:36:34] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:37:04] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:37:34] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:38:04] Block-level synthesis in progress, 5 of 6 jobs complete, 1 job running.
[16:38:34] Top-level synthesis in progress.
[16:39:01] Run vpl: Step synth: Completed
[16:39:01] Run vpl: Step impl: Started
[16:40:32] Finished 3rd of 6 tasks (FPGA logic optimization). Elapsed time: 00h 07m 05s 

[16:40:32] Starting logic placement..
[16:40:32] Phase 1 Placer Initialization
[16:40:32] Phase 1.1 Placer Initialization Netlist Sorting
[16:40:32] Phase 1.2 IO Placement/ Clock Placement/ Build Placer Device
[16:40:32] Finished 2nd of 6 tasks (FPGA linking synthesized kernels to platform). Elapsed time: 00h 00m 00s 

[16:40:32] Starting logic optimization..
[16:40:32] Phase 1 Retarget
[16:40:32] Phase 2 Constant propagation
[16:40:32] Phase 3 Sweep
[16:40:32] Phase 4 BUFG optimization
[16:40:32] Phase 5 Shift Register Optimization
[16:40:32] Phase 6 Post Processing Netlist
[16:41:02] Phase 1.3 Build Placer Netlist Model
[16:41:32] Phase 1.4 Constrain Clocks/Macros
[16:41:32] Phase 2 Global Placement
[16:41:32] Phase 2.1 Floorplanning
[16:41:32] Phase 2.1.1 Partition Driven Placement
[16:41:32] Phase 2.1.1.1 PBP: Partition Driven Placement
[16:42:03] Phase 2.1.1.2 PBP: Clock Region Placement
[16:42:03] Phase 2.1.1.3 PBP: Discrete Incremental
[16:42:03] Phase 2.1.1.4 PBP: Compute Congestion
[16:42:03] Phase 2.1.1.5 PBP: Macro Placement
[16:42:03] Phase 2.1.1.6 PBP: UpdateTiming
[16:42:03] Phase 2.1.1.7 PBP: Add part constraints
[16:42:03] Phase 2.2 Update Timing before SLR Path Opt
[16:42:03] Phase 2.3 Post-Processing in Floorplanning
[16:42:03] Phase 2.4 Global Placement Core
[16:43:03] Phase 2.4.1 UpdateTiming Before Physical Synthesis
[16:43:03] Phase 2.4.2 Physical Synthesis In Placer
[16:43:33] Phase 3 Detail Placement
[16:43:33] Phase 3.1 Commit Multi Column Macros
[16:43:33] Phase 3.2 Commit Most Macros & LUTRAMs
[16:43:33] Phase 3.3 Small Shape DP
[16:43:33] Phase 3.3.1 Small Shape Clustering
[16:43:33] Phase 3.3.2 Flow Legalize Slice Clusters
[16:43:33] Phase 3.3.3 Slice Area Swap
[16:43:33] Phase 3.3.3.1 Slice Area Swap Initial
[16:43:33] Phase 3.4 Re-assign LUT pins
[16:44:03] Phase 3.5 Pipeline Register Optimization
[16:44:03] Phase 4 Post Placement Optimization and Clean-Up
[16:44:03] Phase 4.1 Post Commit Optimization
[16:44:03] Phase 4.1.1 Post Placement Optimization
[16:44:03] Phase 4.1.1.1 BUFG Insertion
[16:44:03] Phase 1 Physical Synthesis Initialization
[16:44:03] Phase 4.1.1.2 Post Placement Timing Optimization
[16:44:33] Phase 4.2 Post Placement Cleanup
[16:44:33] Phase 4.3 Placer Reporting
[16:44:33] Phase 4.3.1 Print Estimated Congestion
[16:44:33] Phase 4.4 Final Placement Cleanup
[16:45:03] Finished 4th of 6 tasks (FPGA logic placement). Elapsed time: 00h 04m 30s 

[16:45:03] Starting logic routing..
[16:45:03] Phase 1 Build RT Design
[16:45:03] Phase 2 Router Initialization
[16:45:03] Phase 2.1 Fix Topology Constraints
[16:45:03] Phase 2.2 Pre Route Cleanup
[16:45:03] Phase 2.3 Global Clock Net Routing
[16:45:03] Phase 2.4 Update Timing
[16:45:33] Phase 2.5 Update Timing for Bus Skew
[16:45:33] Phase 2.5.1 Update Timing
[16:46:03] Phase 3 Initial Routing
[16:46:03] Phase 3.1 Global Routing
[16:46:03] Phase 4 Rip-up And Reroute
[16:46:03] Phase 4.1 Global Iteration 0
[16:51:34] Phase 4.2 Global Iteration 1
[16:51:34] Phase 5 Delay and Skew Optimization
[16:51:34] Phase 5.1 Delay CleanUp
[16:51:34] Phase 5.1.1 Update Timing
[16:51:34] Phase 5.1.2 Update Timing
[16:52:04] Phase 5.2 Clock Skew Optimization
[16:52:04] Phase 6 Post Hold Fix
[16:52:04] Phase 6.1 Hold Fix Iter
[16:52:04] Phase 6.1.1 Update Timing
[16:52:04] Phase 7 Route finalize
[16:52:04] Phase 8 Verifying routed nets
[16:52:04] Phase 9 Depositing Routes
[16:52:04] Phase 10 Resolve XTalk
[16:52:04] Phase 11 Route finalize
[16:52:04] Phase 12 Post Router Timing
[16:52:34] Finished 5th of 6 tasks (FPGA routing). Elapsed time: 00h 07m 31s 

[16:52:34] Starting bitstream generation..
[16:53:05] Creating bitmap...
[16:53:09] Writing bitstream ./kv260_top_wrapper.bit...
[16:53:09] Finished 6th of 6 tasks (FPGA bitstream generation). Elapsed time: 00h 00m 34s 
Check VPL, containing 1 checks, has run: 0 errors
[16:53:08] Run vpl: Step impl: Completed
[16:53:09] Run vpl: FINISHED. Run Status: impl Complete!
INFO: [v++ 60-1441] [16:53:09] Run run_link: Step vpl: Completed
Time (s): cpu = 00:00:04 ; elapsed = 00:19:42 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 21781 ; free virtual = 29444
INFO: [v++ 60-1443] [16:53:09] Run run_link: Step rtdgen: Started
INFO: [v++ 60-1453] Command Line: rtdgen
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1453] Command Line: cf2sw -a /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/address_map.xml -sdsl /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/sdsl.dat -xclbin /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/xclbin_orig.xml -rtd /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.rtd -o /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.xml
INFO: [v++ 60-1652] Cf2sw returned exit code: 0
INFO: [v++ 60-1441] [16:53:10] Run run_link: Step rtdgen: Completed
Time (s): cpu = 00:00:00.86 ; elapsed = 00:00:00.91 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 21804 ; free virtual = 29468
INFO: [v++ 60-1443] [16:53:10] Run run_link: Step xclbinutil: Started
INFO: [v++ 60-1453] Command Line: xclbinutil --add-section BITSTREAM:RAW:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/system.bit --force --target hw --key-value SYS:dfx_enable:false --add-section :JSON:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.rtd --add-section CLOCK_FREQ_TOPOLOGY:JSON:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_xml.rtd --add-section BUILD_METADATA:JSON:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_build.rtd --add-section EMBEDDED_METADATA:RAW:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.xml --add-section SYSTEM_METADATA:RAW:/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/systemDiagramModelSlrBaseAddress.json --key-value SYS:PlatformVBNV:xilinx_kv260_kv260_ppse_hardware_platform_0_0 --output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
XRT Build Version: 2.14.0 (2022.2)
       Build Date: 2024-01-31 18:32:12
          Hash ID: ae8692307adbc1283c67edcc3a220f83b6ad34d9
Creating a default 'in-memory' xclbin image.

Section: 'BITSTREAM'(0) was successfully added.
Size   : 7797813 bytes
Format : RAW
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/system.bit'

Section: 'MEM_TOPOLOGY'(6) was successfully added.
Format : JSON
File   : 'mem_topology'

Section: 'IP_LAYOUT'(8) was successfully added.
Format : JSON
File   : 'ip_layout'

Section: 'CONNECTIVITY'(7) was successfully added.
Format : JSON
File   : 'connectivity'
WARNING: Skipping CLOCK_FREQ_TOPOLOGY section for count size is zero.
WARNING: Section 'CLOCK_FREQ_TOPOLOGY' content is empty.  No data in the given JSON file.

Section: 'CLOCK_FREQ_TOPOLOGY'(11) was empty.  No action taken.
Format : JSON
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_xml.rtd'

Section: 'BUILD_METADATA'(14) was successfully added.
Size   : 4813 bytes
Format : JSON
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1_build.rtd'

Section: 'EMBEDDED_METADATA'(2) was successfully added.
Size   : 4580 bytes
Format : RAW
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/binary_container_1.xml'

Section: 'SYSTEM_METADATA'(22) was successfully added.
Size   : 19963 bytes
Format : RAW
File   : '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/int/systemDiagramModelSlrBaseAddress.json'
Successfully wrote (7838635 bytes) to the output file: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin
Leaving xclbinutil.
INFO: [v++ 60-1441] [16:53:10] Run run_link: Step xclbinutil: Completed
Time (s): cpu = 00:00:00.06 ; elapsed = 00:00:00.07 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 21788 ; free virtual = 29459
INFO: [v++ 60-1443] [16:53:10] Run run_link: Step xclbinutilinfo: Started
INFO: [v++ 60-1453] Command Line: xclbinutil --quiet --force --info /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.info --input /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [16:53:10] Run run_link: Step xclbinutilinfo: Completed
Time (s): cpu = 00:00:00.09 ; elapsed = 00:00:00.1 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 21789 ; free virtual = 29461
INFO: [v++ 60-1443] [16:53:10] Run run_link: Step generate_sc_driver: Started
INFO: [v++ 60-1453] Command Line: 
INFO: [v++ 60-1454] Run Directory: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/link/run_link
INFO: [v++ 60-1441] [16:53:10] Run run_link: Step generate_sc_driver: Completed
Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 439.367 ; gain = 0.000 ; free physical = 21790 ; free virtual = 29462
Check POST-VPL, containing 1 checks, has run: 0 errors
INFO: [v++ 60-244] Generating system estimate report...
INFO: [v++ 60-1092] Generated system estimate report: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/system_estimate_binary_container_1.xtxt
INFO: [v++ 60-2397] Platform default or user specified output type sd_card detected but is not a supported output for v++ --link. Use the v++ --package option instead to create SD card output.
INFO: [v++ 60-586] Created binary_container_1/binary_container_1.xclbin
INFO: [v++ 60-1307] Run completed. Additional information can be found in:
	Guidance: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/v++_link_binary_container_1_guidance.html
	Timing Report: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/reports/link/imp/impl_1_kv260_top_wrapper_timing_summary_routed.rpt
	Vivado Log: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link/vivado.log
	Steps Log File: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/logs/link/link.steps.log

INFO: [v++ 60-2343] Use the vitis_analyzer tool to visualize and navigate the relevant reports. Run the following command. 
    vitis_analyzer /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/binary_container_1.xclbin.link_summary 
INFO: [v++ 60-791] Total elapsed time: 0h 20m 0s
INFO: [v++ 60-1653] Closing dispatch client.
v++ -t hw --platform /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm -p binary_container_1/binary_container_1.xclbin -o binary_container_1/dpu.xclbin --package.out_dir binary_container_1 --package.rootfs /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260_vitis_platform/xilinx-zynqmp-common-v2022.2/rootfs.ext4 --package.sd_file /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260_vitis_platform/xilinx-zynqmp-common-v2022.2/Image 
Option Map File Used: '/home/logictronix03/tools/Xilinx/2022_2/Vitis/2022.2/data/vitis/vpp/optMap.xml'

****** v++ v2022.2 (64-bit)
  **** SW Build 3671529 on 2022-10-13-17:52:11
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

INFO: [v++ 60-1306] Additional information associated with this v++ package can be found at:
	Reports: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/_x/reports/package
	Log files: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/_x/logs/package
Running Dispatch Server on port: 34695
INFO: [v++ 60-1548] Creating build summary session with primary output /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xclbin.package_summary, at Mon Jun 10 16:53:31 2024
INFO: [v++ 60-1315] Creating rulecheck session with output '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/_x/reports/package/v++_package_dpu_guidance.html', at Mon Jun 10 16:53:31 2024
INFO: [v++ 60-895]   Target platform: /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm
INFO: [v++ 60-1578]   This platform contains Xilinx Shell Archive '/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/hw/kv260_ppse_hardware_platform.xsa'
INFO: [v++ 60-2256] Packaging for hardware
INFO: [#UNDEF] For Kria SOM platform, v++ package does not support SD card generation, and no files will be generated
INFO: [v++ 60-2343] Use the vitis_analyzer tool to visualize and navigate the relevant reports. Run the following command. 
    vitis_analyzer /home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis/binary_container_1/dpu.xclbin.package_summary 
INFO: [v++ 60-791] Total elapsed time: 0h 0m 10s
INFO: [v++ 60-1653] Closing dispatch client.
cp ./binary_*/link/vivado/vpl/prj/prj*/sources_1/bd/*/hw_handoff/*.hwh ./binary_*/sd_card
cp: target './binary_*/sd_card' is not a directory
make: *** [Makefile:112: package] Error 1
logictronix03@logictronix03:~/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/DPUCZDX8G_VAI_v3.0/prj/Vitis$ 

