
################################################################
# This is a generated script based on design: kv260_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source kv260_top_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xck26-sfvc784-2LV-c
   set_property BOARD_PART xilinx.com:kv260_som_som240_1_connector_kv260_carrier_som240_1_connector:part0:1.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name kv260_top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_iic:2.1\
prophesee.ai:ip:axis_tkeep_handler:1.1\
xilinx.com:ip:clk_wiz:6.0\
prophesee.ai:ip:event_stream_smart_tracker:1.0\
xilinx.com:ip:mipi_csi2_rx_subsystem:5.2\
prophesee.ai:ip:ps_host_if:2.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:zynq_ultra_ps_e:3.4\
xilinx.com:ip:dpuczdx8g:4.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: hier_dpu_irq
proc create_hier_cell_hier_dpu_irq { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_dpu_irq() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type intr INTR
  create_bd_pin -dir I -from 0 -to 0 In0

  # Create instance: dpu_concat_irq_inner, and set properties
  set dpu_concat_irq_inner [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 dpu_concat_irq_inner ]
  set_property CONFIG.NUM_PORTS {1} $dpu_concat_irq_inner


  # Create port connections
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins dpu_concat_irq_inner/In0]
  connect_bd_net -net dpu_concat_irq_inner_dout [get_bd_pins INTR] [get_bd_pins dpu_concat_irq_inner/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_dpu_ghp
proc create_hier_cell_hier_dpu_ghp { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_dpu_ghp() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 DPU0_M_AXI_DATA0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 DPU0_M_AXI_DATA1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 DPU0_M_AXI_INSTR

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_HP0_FPD

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_HP1_FPD

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_LPD


  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir I -type clk GHP_CLK_I
  create_bd_pin -dir O -type clk GHP_CLK_O
  create_bd_pin -dir I -type rst GHP_RSTn
  create_bd_pin -dir I -type rst RSTn_INTC
  create_bd_pin -dir I -type rst RSTn_PERI

  # Create instance: dpu_intc_M_AXI_HP0_FPD, and set properties
  set dpu_intc_M_AXI_HP0_FPD [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 dpu_intc_M_AXI_HP0_FPD ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {1} \
  ] $dpu_intc_M_AXI_HP0_FPD


  # Create instance: dpu_intc_M_AXI_HP1_FPD, and set properties
  set dpu_intc_M_AXI_HP1_FPD [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 dpu_intc_M_AXI_HP1_FPD ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {1} \
  ] $dpu_intc_M_AXI_HP1_FPD


  # Create instance: dpu_intc_M_AXI_LPD, and set properties
  set dpu_intc_M_AXI_LPD [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 dpu_intc_M_AXI_LPD ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {1} \
  ] $dpu_intc_M_AXI_LPD


  # Create interface connections
  connect_bd_intf_net -intf_net DPU0_M_AXI_DATA0_1 [get_bd_intf_pins DPU0_M_AXI_DATA0] [get_bd_intf_pins dpu_intc_M_AXI_HP0_FPD/S00_AXI]
  connect_bd_intf_net -intf_net DPU0_M_AXI_DATA1_1 [get_bd_intf_pins DPU0_M_AXI_DATA1] [get_bd_intf_pins dpu_intc_M_AXI_HP1_FPD/S00_AXI]
  connect_bd_intf_net -intf_net DPU0_M_AXI_INSTR_1 [get_bd_intf_pins DPU0_M_AXI_INSTR] [get_bd_intf_pins dpu_intc_M_AXI_LPD/S00_AXI]
  connect_bd_intf_net -intf_net dpu_intc_M_AXI_HP0_FPD_M00_AXI [get_bd_intf_pins M_AXI_HP0_FPD] [get_bd_intf_pins dpu_intc_M_AXI_HP0_FPD/M00_AXI]
  connect_bd_intf_net -intf_net dpu_intc_M_AXI_HP1_FPD_M00_AXI [get_bd_intf_pins M_AXI_HP1_FPD] [get_bd_intf_pins dpu_intc_M_AXI_HP1_FPD/M00_AXI]
  connect_bd_intf_net -intf_net dpu_intc_M_AXI_LPD_M00_AXI [get_bd_intf_pins M_AXI_LPD] [get_bd_intf_pins dpu_intc_M_AXI_LPD/M00_AXI]

  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins dpu_intc_M_AXI_HP0_FPD/ACLK] [get_bd_pins dpu_intc_M_AXI_HP0_FPD/S00_ACLK] [get_bd_pins dpu_intc_M_AXI_HP1_FPD/ACLK] [get_bd_pins dpu_intc_M_AXI_HP1_FPD/S00_ACLK] [get_bd_pins dpu_intc_M_AXI_LPD/ACLK] [get_bd_pins dpu_intc_M_AXI_LPD/S00_ACLK]
  connect_bd_net -net GHP_CLK_I_1 [get_bd_pins GHP_CLK_I] [get_bd_pins GHP_CLK_O] [get_bd_pins dpu_intc_M_AXI_HP0_FPD/M00_ACLK] [get_bd_pins dpu_intc_M_AXI_HP1_FPD/M00_ACLK] [get_bd_pins dpu_intc_M_AXI_LPD/M00_ACLK]
  connect_bd_net -net GHP_RSTn_1 [get_bd_pins GHP_RSTn] [get_bd_pins dpu_intc_M_AXI_HP0_FPD/M00_ARESETN] [get_bd_pins dpu_intc_M_AXI_HP1_FPD/M00_ARESETN] [get_bd_pins dpu_intc_M_AXI_LPD/M00_ARESETN]
  connect_bd_net -net RSTn_INTC_1 [get_bd_pins RSTn_INTC] [get_bd_pins dpu_intc_M_AXI_HP0_FPD/ARESETN] [get_bd_pins dpu_intc_M_AXI_HP1_FPD/ARESETN] [get_bd_pins dpu_intc_M_AXI_LPD/ARESETN]
  connect_bd_net -net RSTn_PERI_1 [get_bd_pins RSTn_PERI] [get_bd_pins dpu_intc_M_AXI_HP0_FPD/S00_ARESETN] [get_bd_pins dpu_intc_M_AXI_HP1_FPD/S00_ARESETN] [get_bd_pins dpu_intc_M_AXI_LPD/S00_ARESETN]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_dpu_clk
proc create_hier_cell_hier_dpu_clk { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_dpu_clk() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -type clk DPU_CLK
  create_bd_pin -dir O -type clk DSP_CLK
  create_bd_pin -dir O -type data LOCKED
  create_bd_pin -dir I -type rst RSTn
  create_bd_pin -dir O -from 0 -to 0 -type rst RSTn_DSP
  create_bd_pin -dir O -from 0 -to 0 -type rst RSTn_INTC
  create_bd_pin -dir O -from 0 -to 0 -type rst RSTn_PERI
  create_bd_pin -dir I -type ce clk_dsp_ce

  # Create instance: dpu_clk_wiz, and set properties
  set dpu_clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 dpu_clk_wiz ]
  set_property -dict [list \
    CONFIG.AUTO_PRIMITIVE {PLL} \
    CONFIG.CLKIN1_JITTER_PS {100.0} \
    CONFIG.CLKOUT1_DRIVES {Buffer_with_CE} \
    CONFIG.CLKOUT1_JITTER {90.570} \
    CONFIG.CLKOUT1_MATCHED_ROUTING {true} \
    CONFIG.CLKOUT1_PHASE_ERROR {92.673} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {550} \
    CONFIG.CLKOUT2_JITTER {102.699} \
    CONFIG.CLKOUT2_MATCHED_ROUTING {true} \
    CONFIG.CLKOUT2_PHASE_ERROR {92.673} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {275} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLK_OUT1_PORT {clk_dsp} \
    CONFIG.CLK_OUT2_PORT {clk_dpu} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {11} \
    CONFIG.MMCM_CLKIN1_PERIOD {10.000} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {2} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
    CONFIG.NUM_OUT_CLKS {2} \
    CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
    CONFIG.PRIMITIVE {Auto} \
    CONFIG.RESET_PORT {resetn} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.USE_RESET {true} \
  ] $dpu_clk_wiz


  # Create instance: rst_gen_clk, and set properties
  set rst_gen_clk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_gen_clk ]

  # Create instance: rst_gen_clk_dsp, and set properties
  set rst_gen_clk_dsp [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_gen_clk_dsp ]

  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins dpu_clk_wiz/clk_in1]
  connect_bd_net -net RSTn_1 [get_bd_pins RSTn] [get_bd_pins dpu_clk_wiz/resetn] [get_bd_pins rst_gen_clk/ext_reset_in] [get_bd_pins rst_gen_clk_dsp/ext_reset_in]
  connect_bd_net -net clk_dsp_ce_1 [get_bd_pins clk_dsp_ce] [get_bd_pins dpu_clk_wiz/clk_dsp_ce]
  connect_bd_net -net dpu_clk_wiz_clk_dpu [get_bd_pins DPU_CLK] [get_bd_pins dpu_clk_wiz/clk_dpu] [get_bd_pins rst_gen_clk/slowest_sync_clk]
  connect_bd_net -net dpu_clk_wiz_clk_dsp [get_bd_pins DSP_CLK] [get_bd_pins dpu_clk_wiz/clk_dsp] [get_bd_pins rst_gen_clk_dsp/slowest_sync_clk]
  connect_bd_net -net dpu_clk_wiz_locked [get_bd_pins LOCKED] [get_bd_pins dpu_clk_wiz/locked] [get_bd_pins rst_gen_clk/dcm_locked] [get_bd_pins rst_gen_clk_dsp/dcm_locked]
  connect_bd_net -net rst_gen_clk_dsp_peripheral_aresetn [get_bd_pins RSTn_DSP] [get_bd_pins rst_gen_clk_dsp/peripheral_aresetn]
  connect_bd_net -net rst_gen_clk_interconnect_aresetn [get_bd_pins RSTn_INTC] [get_bd_pins rst_gen_clk/interconnect_aresetn]
  connect_bd_net -net rst_gen_clk_peripheral_aresetn [get_bd_pins RSTn_PERI] [get_bd_pins rst_gen_clk/peripheral_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_dpu
proc create_hier_cell_hier_dpu { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_dpu() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_HP0_FPD

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_HP1_FPD

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_LPD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir I -type clk GHP_CLK_I
  create_bd_pin -dir O -type clk GHP_CLK_O
  create_bd_pin -dir I -type rst GHP_RSTn
  create_bd_pin -dir O -from 0 -to 0 -type intr INTR
  create_bd_pin -dir I -type rst RSTn
  create_bd_pin -dir I -type clk S_AXI_CLK
  create_bd_pin -dir I -type rst S_AXI_RSTn

  # Create instance: DPUCZDX8G, and set properties
  set DPUCZDX8G [ create_bd_cell -type ip -vlnv xilinx.com:ip:dpuczdx8g:4.1 DPUCZDX8G ]
  set_property -dict [list \
    CONFIG.ALU_LEAKYRELU {0} \
    CONFIG.ALU_PARALLEL_USER {4} \
    CONFIG.ARCH {4096} \
    CONFIG.ARCH_IMG_BKGRP {2} \
    CONFIG.CLK_GATING_ENA {1} \
    CONFIG.CONV_DSP_ACCU_ENA {1} \
    CONFIG.CONV_DSP_CASC_MAX {4} \
    CONFIG.CONV_RELU_ADDON {3} \
    CONFIG.CONV_WR_PARALLEL {1} \
    CONFIG.LOAD_AUGM {1} \
    CONFIG.SAVE_ARGMAX_ENA {1} \
    CONFIG.SFM_ENA {0} \
    CONFIG.S_AXI_CLK_INDEPENDENT {1} \
    CONFIG.TIMESTAMP_ENA {1} \
    CONFIG.TIME_DAY {2} \
    CONFIG.TIME_HOUR {19} \
    CONFIG.TIME_MONTH {5} \
    CONFIG.TIME_QUARTER {0} \
    CONFIG.TIME_YEAR {24} \
    CONFIG.URAM_N_USER {50} \
    CONFIG.VER_DPU_NUM {1} \
  ] $DPUCZDX8G


  # Create instance: hier_dpu_clk
  create_hier_cell_hier_dpu_clk $hier_obj hier_dpu_clk

  # Create instance: hier_dpu_ghp
  create_hier_cell_hier_dpu_ghp $hier_obj hier_dpu_ghp

  # Create instance: hier_dpu_irq
  create_hier_cell_hier_dpu_irq $hier_obj hier_dpu_irq

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI_HP0_FPD] [get_bd_intf_pins hier_dpu_ghp/M_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_AXI_HP1_FPD] [get_bd_intf_pins hier_dpu_ghp/M_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins M_AXI_LPD] [get_bd_intf_pins hier_dpu_ghp/M_AXI_LPD]
  connect_bd_intf_net -intf_net DPUCZDX8G_DPU0_M_AXI_DATA0 [get_bd_intf_pins DPUCZDX8G/DPU0_M_AXI_DATA0] [get_bd_intf_pins hier_dpu_ghp/DPU0_M_AXI_DATA0]
  connect_bd_intf_net -intf_net DPUCZDX8G_DPU0_M_AXI_DATA1 [get_bd_intf_pins DPUCZDX8G/DPU0_M_AXI_DATA1] [get_bd_intf_pins hier_dpu_ghp/DPU0_M_AXI_DATA1]
  connect_bd_intf_net -intf_net DPUCZDX8G_DPU0_M_AXI_INSTR [get_bd_intf_pins DPUCZDX8G/DPU0_M_AXI_INSTR] [get_bd_intf_pins hier_dpu_ghp/DPU0_M_AXI_INSTR]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins DPUCZDX8G/S_AXI]

  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins hier_dpu_clk/CLK]
  connect_bd_net -net DPUCZDX8G_dpu0_interrupt [get_bd_pins DPUCZDX8G/dpu0_interrupt] [get_bd_pins hier_dpu_irq/In0]
  connect_bd_net -net DPUCZDX8G_dpu_2x_clk_ce [get_bd_pins DPUCZDX8G/dpu_2x_clk_ce] [get_bd_pins hier_dpu_clk/clk_dsp_ce]
  connect_bd_net -net GHP_CLK_I_1 [get_bd_pins GHP_CLK_I] [get_bd_pins hier_dpu_ghp/GHP_CLK_I]
  connect_bd_net -net GHP_RSTn_1 [get_bd_pins GHP_RSTn] [get_bd_pins hier_dpu_ghp/GHP_RSTn]
  connect_bd_net -net RSTn_1 [get_bd_pins RSTn] [get_bd_pins hier_dpu_clk/RSTn]
  connect_bd_net -net S_AXI_CLK_1 [get_bd_pins S_AXI_CLK] [get_bd_pins DPUCZDX8G/s_axi_aclk]
  connect_bd_net -net S_AXI_RSTn_1 [get_bd_pins S_AXI_RSTn] [get_bd_pins DPUCZDX8G/s_axi_aresetn]
  connect_bd_net -net hier_dpu_clk_DPU_CLK [get_bd_pins DPUCZDX8G/m_axi_dpu_aclk] [get_bd_pins hier_dpu_clk/DPU_CLK] [get_bd_pins hier_dpu_ghp/CLK]
  connect_bd_net -net hier_dpu_clk_DSP_CLK [get_bd_pins DPUCZDX8G/dpu_2x_clk] [get_bd_pins hier_dpu_clk/DSP_CLK]
  connect_bd_net -net hier_dpu_clk_RSTn_DSP [get_bd_pins DPUCZDX8G/dpu_2x_resetn] [get_bd_pins hier_dpu_clk/RSTn_DSP]
  connect_bd_net -net hier_dpu_clk_RSTn_INTC [get_bd_pins hier_dpu_clk/RSTn_INTC] [get_bd_pins hier_dpu_ghp/RSTn_INTC]
  connect_bd_net -net hier_dpu_clk_RSTn_PERI [get_bd_pins DPUCZDX8G/m_axi_dpu_aresetn] [get_bd_pins hier_dpu_clk/RSTn_PERI] [get_bd_pins hier_dpu_ghp/RSTn_PERI]
  connect_bd_net -net hier_dpu_ghp_GHP_CLK_O [get_bd_pins GHP_CLK_O] [get_bd_pins hier_dpu_ghp/GHP_CLK_O]
  connect_bd_net -net hier_dpu_irq_INTR [get_bd_pins INTR] [get_bd_pins hier_dpu_irq/INTR]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ccam5_csi_rx [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 ccam5_csi_rx ]

  set ccam5_i2c [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ccam5_i2c ]

  set gpio_generic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_generic ]


  # Create ports
  set fan_en_b [ create_bd_port -dir O -from 0 -to 0 fan_en_b ]

  # Create instance: PL_PS_IRQ, and set properties
  set PL_PS_IRQ [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 PL_PS_IRQ ]
  set_property CONFIG.NUM_PORTS {4} $PL_PS_IRQ


  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [list \
    CONFIG.PROTOCOL {AXI4LITE} \
    CONFIG.SINGLE_PORT_BRAM {1} \
  ] $axi_bram_ctrl_0


  # Create instance: axi_dma, and set properties
  set axi_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma ]
  set_property -dict [list \
    CONFIG.c_addr_width {33} \
    CONFIG.c_include_mm2s {1} \
    CONFIG.c_include_sg {1} \
    CONFIG.c_m_axi_mm2s_data_width {64} \
    CONFIG.c_m_axis_mm2s_tdata_width {64} \
    CONFIG.c_micro_dma {0} \
    CONFIG.c_mm2s_burst_size {8} \
    CONFIG.c_s2mm_burst_size {256} \
    CONFIG.c_sg_include_stscntrl_strm {0} \
    CONFIG.c_sg_length_width {26} \
  ] $axi_dma


  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $axi_gpio_0


  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0 ]
  set_property -dict [list \
    CONFIG.IIC_BOARD_INTERFACE {som240_1_connector_hda_iic_switch} \
    CONFIG.IIC_FREQ_KHZ {400} \
  ] $axi_iic_0


  # Create instance: axi_interconnect_hp0, and set properties
  set axi_interconnect_hp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_hp0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {3} \
  ] $axi_interconnect_hp0


  # Create instance: axi_interconnect_master_lpd, and set properties
  set axi_interconnect_master_lpd [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_master_lpd ]
  set_property CONFIG.NUM_MI {8} $axi_interconnect_master_lpd


  # Create instance: axis_tkeep_handler_0, and set properties
  set axis_tkeep_handler_0 [ create_bd_cell -type ip -vlnv prophesee.ai:ip:axis_tkeep_handler:1.1 axis_tkeep_handler_0 ]

  # Create instance: core_clock_0, and set properties
  set core_clock_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 core_clock_0 ]
  set_property -dict [list \
    CONFIG.CLKIN1_JITTER_PS {75.0} \
    CONFIG.CLKOUT1_DRIVES {BUFGCE} \
    CONFIG.CLKOUT1_JITTER {105.937} \
    CONFIG.CLKOUT1_PHASE_ERROR {85.441} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {133.332001} \
    CONFIG.CLKOUT2_DRIVES {BUFGCE} \
    CONFIG.CLKOUT2_JITTER {98.191} \
    CONFIG.CLKOUT2_PHASE_ERROR {85.441} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {200.000} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLKOUT3_DRIVES {BUFGCE} \
    CONFIG.CLKOUT4_DRIVES {BUFGCE} \
    CONFIG.CLKOUT5_DRIVES {BUFGCE} \
    CONFIG.CLKOUT6_DRIVES {BUFGCE} \
    CONFIG.CLKOUT7_DRIVES {BUFGCE} \
    CONFIG.CLK_OUT1_PORT {core_clk_o} \
    CONFIG.CLK_OUT2_PORT {mipi_dphy_clk_o} \
    CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {9.000} \
    CONFIG.MMCM_CLKIN1_PERIOD {7.500} \
    CONFIG.MMCM_CLKIN2_PERIOD {10.000} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {9.000} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {6} \
    CONFIG.MMCM_DIVCLK_DIVIDE {1} \
    CONFIG.NUM_OUT_CLKS {2} \
    CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
    CONFIG.PRIM_SOURCE {No_buffer} \
    CONFIG.RESET_PORT {resetn} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_SAFE_CLOCK_STARTUP {true} \
  ] $core_clock_0


  # Create instance: event_stream_smart_t_0, and set properties
  set event_stream_smart_t_0 [ create_bd_cell -type ip -vlnv prophesee.ai:ip:event_stream_smart_tracker:1.0 event_stream_smart_t_0 ]
  set_property CONFIG.SMART_DROP_FIFO_DEPTH_G {64} $event_stream_smart_t_0


  # Create instance: hier_dpu
  create_hier_cell_hier_dpu [current_bd_instance .] hier_dpu

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_0 ]
  set_property -dict [list \
    CONFIG.AXIS_TDATA_WIDTH {64} \
    CONFIG.AXIS_TDEST_WIDTH {10} \
    CONFIG.CMN_INC_VFB {false} \
    CONFIG.CMN_NUM_LANES {2} \
    CONFIG.CMN_PXL_FORMAT {RAW8} \
    CONFIG.CSI_BUF_DEPTH {16384} \
    CONFIG.C_CSI_EN_ACTIVELANES {true} \
    CONFIG.C_CSI_EN_CRC {true} \
    CONFIG.DPHYRX_BOARD_INTERFACE {som240_1_connector_mipi_csi_raspi} \
    CONFIG.DPY_EN_REG_IF {true} \
    CONFIG.DPY_LINE_RATE {1500} \
    CONFIG.SupportLevel {1} \
  ] $mipi_csi2_rx_subsyst_0


  # Create instance: ps_host_if_0, and set properties
  set ps_host_if_0 [ create_bd_cell -type ip -vlnv prophesee.ai:ip:ps_host_if:2.1 ps_host_if_0 ]

  # Create instance: ps_system_reset, and set properties
  set ps_system_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ps_system_reset ]
  set_property -dict [list \
    CONFIG.C_EXT_RST_WIDTH {4} \
    CONFIG.C_NUM_PERP_ARESETN {1} \
  ] $ps_system_reset


  # Create instance: rst_gen_ghp, and set properties
  set rst_gen_ghp [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_gen_ghp ]

  # Create instance: rst_gen_reg, and set properties
  set rst_gen_reg [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_gen_reg ]

  # Create instance: system_register, and set properties
  set system_register [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 system_register ]
  set_property -dict [list \
    CONFIG.Coe_File {/home/logictronix03/Downloads/kk/kv260/kv260.srcs/sources_1/imports/srcs/coe/kv260_system_register.coe} \
    CONFIG.EN_SAFETY_CKT {false} \
    CONFIG.EN_SLEEP_PIN {false} \
    CONFIG.Enable_32bit_Address {true} \
    CONFIG.Load_Init_File {true} \
    CONFIG.Memory_Type {Single_Port_ROM} \
    CONFIG.Register_PortA_Output_of_Memory_Core {false} \
    CONFIG.use_bram_block {BRAM_Controller} \
  ] $system_register


  # Create instance: vcc_constant, and set properties
  set vcc_constant [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 vcc_constant ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {2} \
    CONFIG.DIN_TO {2} \
    CONFIG.DIN_WIDTH {3} \
  ] $xlslice_0


  # Create instance: zynq_processing_system, and set properties
  set zynq_processing_system [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.4 zynq_processing_system ]
  set_property -dict [list \
    CONFIG.CAN0_BOARD_INTERFACE {custom} \
    CONFIG.CAN1_BOARD_INTERFACE {custom} \
    CONFIG.CSU_BOARD_INTERFACE {custom} \
    CONFIG.DP_BOARD_INTERFACE {custom} \
    CONFIG.GEM0_BOARD_INTERFACE {custom} \
    CONFIG.GEM1_BOARD_INTERFACE {custom} \
    CONFIG.GEM2_BOARD_INTERFACE {custom} \
    CONFIG.GEM3_BOARD_INTERFACE {custom} \
    CONFIG.GPIO_BOARD_INTERFACE {custom} \
    CONFIG.IIC0_BOARD_INTERFACE {custom} \
    CONFIG.IIC1_BOARD_INTERFACE {custom} \
    CONFIG.NAND_BOARD_INTERFACE {custom} \
    CONFIG.PCIE_BOARD_INTERFACE {custom} \
    CONFIG.PJTAG_BOARD_INTERFACE {custom} \
    CONFIG.PMU_BOARD_INTERFACE {custom} \
    CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
    CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
    CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
    CONFIG.PSU_IMPORT_BOARD_PRESET {} \
    CONFIG.PSU_MIO_0_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_0_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_0_SLEW {slow} \
    CONFIG.PSU_MIO_10_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_10_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_10_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_10_SLEW {slow} \
    CONFIG.PSU_MIO_11_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_11_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_11_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_11_SLEW {slow} \
    CONFIG.PSU_MIO_12_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_12_POLARITY {Default} \
    CONFIG.PSU_MIO_12_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_12_SLEW {slow} \
    CONFIG.PSU_MIO_13_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_13_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_13_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_13_SLEW {slow} \
    CONFIG.PSU_MIO_14_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_14_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_14_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_14_SLEW {slow} \
    CONFIG.PSU_MIO_15_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_15_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_15_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_15_SLEW {slow} \
    CONFIG.PSU_MIO_16_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_16_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_16_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_16_SLEW {slow} \
    CONFIG.PSU_MIO_17_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_17_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_17_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_17_SLEW {slow} \
    CONFIG.PSU_MIO_18_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_18_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_18_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_18_SLEW {slow} \
    CONFIG.PSU_MIO_19_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_19_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_19_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_SLEW {slow} \
    CONFIG.PSU_MIO_1_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_1_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_1_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_1_SLEW {slow} \
    CONFIG.PSU_MIO_20_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_20_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_20_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_20_SLEW {slow} \
    CONFIG.PSU_MIO_21_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_21_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_21_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_21_SLEW {slow} \
    CONFIG.PSU_MIO_22_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_22_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_SLEW {slow} \
    CONFIG.PSU_MIO_23_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_23_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_23_SLEW {slow} \
    CONFIG.PSU_MIO_24_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_24_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_24_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_24_SLEW {slow} \
    CONFIG.PSU_MIO_25_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_25_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_25_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_25_SLEW {slow} \
    CONFIG.PSU_MIO_26_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_26_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_27_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_27_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_27_SLEW {slow} \
    CONFIG.PSU_MIO_28_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_28_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_29_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_SLEW {slow} \
    CONFIG.PSU_MIO_2_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_2_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_2_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_2_SLEW {slow} \
    CONFIG.PSU_MIO_30_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_30_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_31_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_31_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_32_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_32_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_32_SLEW {slow} \
    CONFIG.PSU_MIO_33_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_33_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_33_SLEW {slow} \
    CONFIG.PSU_MIO_34_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_34_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_34_SLEW {slow} \
    CONFIG.PSU_MIO_35_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_35_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_35_SLEW {slow} \
    CONFIG.PSU_MIO_36_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_36_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_36_SLEW {slow} \
    CONFIG.PSU_MIO_37_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_37_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_38_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_38_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_38_POLARITY {Default} \
    CONFIG.PSU_MIO_38_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_38_SLEW {slow} \
    CONFIG.PSU_MIO_39_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_39_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_39_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_39_SLEW {slow} \
    CONFIG.PSU_MIO_3_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_3_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_3_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_3_SLEW {slow} \
    CONFIG.PSU_MIO_40_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_40_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_40_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_40_SLEW {slow} \
    CONFIG.PSU_MIO_41_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_41_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_41_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_41_SLEW {slow} \
    CONFIG.PSU_MIO_42_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_42_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_42_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_42_SLEW {slow} \
    CONFIG.PSU_MIO_43_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_43_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_43_SLEW {slow} \
    CONFIG.PSU_MIO_44_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_44_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_44_POLARITY {Default} \
    CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_44_SLEW {slow} \
    CONFIG.PSU_MIO_45_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_45_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_46_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_46_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_SLEW {slow} \
    CONFIG.PSU_MIO_47_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_47_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_47_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_47_SLEW {slow} \
    CONFIG.PSU_MIO_48_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_48_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_48_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_48_SLEW {slow} \
    CONFIG.PSU_MIO_49_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_49_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_49_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_49_SLEW {slow} \
    CONFIG.PSU_MIO_4_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_4_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_4_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_4_SLEW {slow} \
    CONFIG.PSU_MIO_50_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_50_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_50_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_50_SLEW {slow} \
    CONFIG.PSU_MIO_51_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_51_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_51_SLEW {slow} \
    CONFIG.PSU_MIO_52_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_52_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_53_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_53_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_54_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_54_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_SLEW {slow} \
    CONFIG.PSU_MIO_55_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_55_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_56_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_56_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_SLEW {slow} \
    CONFIG.PSU_MIO_57_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_57_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_57_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_57_SLEW {slow} \
    CONFIG.PSU_MIO_58_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_58_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_58_SLEW {slow} \
    CONFIG.PSU_MIO_59_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_59_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_59_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_59_SLEW {slow} \
    CONFIG.PSU_MIO_5_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_5_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_5_SLEW {slow} \
    CONFIG.PSU_MIO_60_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_60_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_60_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_60_SLEW {slow} \
    CONFIG.PSU_MIO_61_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_61_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_61_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_61_SLEW {slow} \
    CONFIG.PSU_MIO_62_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_62_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_62_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_62_SLEW {slow} \
    CONFIG.PSU_MIO_63_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_63_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_63_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_63_SLEW {slow} \
    CONFIG.PSU_MIO_64_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_64_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_64_SLEW {slow} \
    CONFIG.PSU_MIO_65_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_65_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_65_SLEW {slow} \
    CONFIG.PSU_MIO_66_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_66_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_66_SLEW {slow} \
    CONFIG.PSU_MIO_67_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_67_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_67_SLEW {slow} \
    CONFIG.PSU_MIO_68_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_68_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_68_SLEW {slow} \
    CONFIG.PSU_MIO_69_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_69_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_69_SLEW {slow} \
    CONFIG.PSU_MIO_6_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_6_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_6_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_6_SLEW {slow} \
    CONFIG.PSU_MIO_70_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_70_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_71_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_71_PULLUPDOWN {disable} \
    CONFIG.PSU_MIO_72_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_72_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_73_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_73_PULLUPDOWN {disable} \
    CONFIG.PSU_MIO_74_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_74_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_75_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_75_PULLUPDOWN {disable} \
    CONFIG.PSU_MIO_76_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_76_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_SLEW {slow} \
    CONFIG.PSU_MIO_77_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_77_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_77_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_77_SLEW {slow} \
    CONFIG.PSU_MIO_7_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_7_POLARITY {Default} \
    CONFIG.PSU_MIO_7_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_7_SLEW {slow} \
    CONFIG.PSU_MIO_8_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_8_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_8_POLARITY {Default} \
    CONFIG.PSU_MIO_8_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_8_SLEW {slow} \
    CONFIG.PSU_MIO_9_DRIVE_STRENGTH {4} \
    CONFIG.PSU_MIO_9_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_9_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_9_SLEW {slow} \
    CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#SPI 1#GPIO0 MIO#GPIO0 MIO#SPI 1#SPI 1#SPI 1#GPIO0 MIO#SD 0#SD 0#SD 0#SD 0#SD\
0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#I2C 1#I2C 1#PMU GPI 0#DPAUX#DPAUX#DPAUX#DPAUX#PMU GPI 5#PMU GPO 0#PMU GPO 1#PMU GPO 2#PMU GPO 3#UART 1#UART 1#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#GPIO1 MIO#SD 1#SD 1#SD 1#SD\
1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
    CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#sclk_out#gpio0[7]#gpio0[8]#n_ss_out[0]#miso#mosi#gpio0[12]#sdio0_data_out[0]#sdio0_data_out[1]#sdio0_data_out[2]#sdio0_data_out[3]#sdio0_data_out[4]#sdio0_data_out[5]#sdio0_data_out[6]#sdio0_data_out[7]#sdio0_cmd_out#sdio0_clk_out#sdio0_bus_pow#scl_out#sda_out#gpi[0]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#gpi[5]#gpo[0]#gpo[1]#gpo[2]#gpo[3]#txd#rxd#gpio1[38]#sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#sdio1_bus_pow#gpio1[44]#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out}\
\
    CONFIG.PSU_PERIPHERAL_BOARD_PRESET {} \
    CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SMC_CYCLE_T0 {NA} \
    CONFIG.PSU_SMC_CYCLE_T1 {NA} \
    CONFIG.PSU_SMC_CYCLE_T2 {NA} \
    CONFIG.PSU_SMC_CYCLE_T3 {NA} \
    CONFIG.PSU_SMC_CYCLE_T4 {NA} \
    CONFIG.PSU_SMC_CYCLE_T5 {NA} \
    CONFIG.PSU_SMC_CYCLE_T6 {NA} \
    CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
    CONFIG.PSU_VALUE_SILVERSION {3} \
    CONFIG.PSU__ACPU0__POWER__ON {1} \
    CONFIG.PSU__ACPU1__POWER__ON {1} \
    CONFIG.PSU__ACPU2__POWER__ON {1} \
    CONFIG.PSU__ACPU3__POWER__ON {1} \
    CONFIG.PSU__ACTUAL__IP {1} \
    CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.656006} \
    CONFIG.PSU__AFI0_COHERENCY {0} \
    CONFIG.PSU__AUX_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__CAN0_LOOP_CAN1__ENABLE {0} \
    CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1333.333008} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1333.333} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__ACPU__FRAC_ENABLED {1} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI0_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI1_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI2_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI3_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI4_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI5_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__FRACFREQ {1333.333} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__ACT_FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__DIVISOR0 {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1200} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {444.444336} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.242182} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.666401} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.997009} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {300} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__ACT_FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__DIVISOR0 {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__SRCSEL {NA} \
    CONFIG.PSU__CRF_APB__GTGREF0__ENABLE {NA} \
    CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {249.999975} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6__ENABLE {0} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__FREQMHZ {50} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__ACT_FREQMHZ {99.999990} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {533.333} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__FREQMHZ {400} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__ACT_FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__DIVISOR0 {6} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__FREQMHZ {1500} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {124.999988} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {124.999988} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.998749} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {133.332001} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {133.333333} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__ACT_FREQMHZ {266.664001} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__FREQMHZ {274} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__PL3_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.998749} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
    CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
    CONFIG.PSU__CSU__CSU_TAMPER_0__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_10__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_11__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_12__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_1__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_2__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_3__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_4__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_5__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_6__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_7__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_8__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_9__ENABLE {0} \
    CONFIG.PSU__CSU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DDRC__AL {0} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
    CONFIG.PSU__DDRC__CL {16} \
    CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
    CONFIG.PSU__DDRC__COMPONENTS {Components} \
    CONFIG.PSU__DDRC__CWL {14} \
    CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
    CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
    CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
    CONFIG.PSU__DDRC__DDR4_MAXPWR_SAVING_EN {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
    CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__ECC_SCRUB {0} \
    CONFIG.PSU__DDRC__ENABLE {1} \
    CONFIG.PSU__DDRC__ENABLE_2T_TIMING {0} \
    CONFIG.PSU__DDRC__ENABLE_DP_SWITCH {0} \
    CONFIG.PSU__DDRC__EN_2ND_CLK {0} \
    CONFIG.PSU__DDRC__FGRM {1X} \
    CONFIG.PSU__DDRC__FREQ_MHZ {1066.50} \
    CONFIG.PSU__DDRC__LPDDR3_DUALRANK_SDP {0} \
    CONFIG.PSU__DDRC__LP_ASR {manual normal} \
    CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
    CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
    CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
    CONFIG.PSU__DDRC__PLL_BYPASS {0} \
    CONFIG.PSU__DDRC__PWR_DOWN_EN {0} \
    CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
    CONFIG.PSU__DDRC__RD_DQS_CENTER {0} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400R} \
    CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
    CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
    CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
    CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
    CONFIG.PSU__DDRC__T_FAW {30.0} \
    CONFIG.PSU__DDRC__T_RAS_MIN {33} \
    CONFIG.PSU__DDRC__T_RC {47.06} \
    CONFIG.PSU__DDRC__T_RCD {16} \
    CONFIG.PSU__DDRC__T_RP {16} \
    CONFIG.PSU__DDRC__VIDEO_BUFFER_SIZE {0} \
    CONFIG.PSU__DDRC__VREF {1} \
    CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
    CONFIG.PSU__DDR_QOS_ENABLE {0} \
    CONFIG.PSU__DDR_QOS_HP0_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP0_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_WRQOS {} \
    CONFIG.PSU__DDR_SW_REFRESH_ENABLED {1} \
    CONFIG.PSU__DDR__INTERFACE__FREQMHZ {600.000} \
    CONFIG.PSU__DEVICE_TYPE {EV} \
    CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
    CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
    CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
    CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
    CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__DLL__ISUSED {1} \
    CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
    CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
    CONFIG.PSU__DP__REF_CLK_FREQ {27} \
    CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk0} \
    CONFIG.PSU__ENABLE__DDR__REFRESH__SIGNALS {0} \
    CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
    CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
    CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
    CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
    CONFIG.PSU__ENET3__PTP__ENABLE {0} \
    CONFIG.PSU__ENET3__TSU__ENABLE {0} \
    CONFIG.PSU__EN_AXI_STATUS_PORTS {0} \
    CONFIG.PSU__EN_EMIO_TRACE {0} \
    CONFIG.PSU__EP__IP {0} \
    CONFIG.PSU__EXPAND__CORESIGHT {0} \
    CONFIG.PSU__EXPAND__FPD_SLAVES {0} \
    CONFIG.PSU__EXPAND__GIC {0} \
    CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {0} \
    CONFIG.PSU__EXPAND__UPPER_LPS_SLAVES {0} \
    CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
    CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__FPGA_PL0_ENABLE {1} \
    CONFIG.PSU__FPGA_PL1_ENABLE {1} \
    CONFIG.PSU__FPGA_PL2_ENABLE {1} \
    CONFIG.PSU__FPGA_PL3_ENABLE {0} \
    CONFIG.PSU__FP__POWER__ON {1} \
    CONFIG.PSU__FTM__CTI_IN_0 {0} \
    CONFIG.PSU__FTM__CTI_IN_1 {0} \
    CONFIG.PSU__FTM__CTI_IN_2 {0} \
    CONFIG.PSU__FTM__CTI_IN_3 {0} \
    CONFIG.PSU__FTM__CTI_OUT_0 {0} \
    CONFIG.PSU__FTM__CTI_OUT_1 {0} \
    CONFIG.PSU__FTM__CTI_OUT_2 {0} \
    CONFIG.PSU__FTM__CTI_OUT_3 {0} \
    CONFIG.PSU__FTM__GPI {0} \
    CONFIG.PSU__FTM__GPO {0} \
    CONFIG.PSU__GEM3_COHERENCY {0} \
    CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__GEM__TSU__ENABLE {0} \
    CONFIG.PSU__GEN_IPI_0__MASTER {APU} \
    CONFIG.PSU__GEN_IPI_10__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_1__MASTER {RPU0} \
    CONFIG.PSU__GEN_IPI_2__MASTER {RPU1} \
    CONFIG.PSU__GEN_IPI_3__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_4__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_5__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_6__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_7__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_8__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_9__MASTER {NONE} \
    CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
    CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
    CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO_EMIO_WIDTH {32} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {32} \
    CONFIG.PSU__GPIO_EMIO__WIDTH {[93:0]} \
    CONFIG.PSU__GPU_PP0__POWER__ON {1} \
    CONFIG.PSU__GPU_PP1__POWER__ON {1} \
    CONFIG.PSU__GT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__GT__LINK_SPEED {HBR} \
    CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
    CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
    CONFIG.PSU__HPM0_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__I2C0_LOOP_I2C1__ENABLE {0} \
    CONFIG.PSU__I2C0__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__I2C1__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 24 .. 25} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__IRQ_P2F_ADMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_AIB_AXI__INT {0} \
    CONFIG.PSU__IRQ_P2F_AMS__INT {0} \
    CONFIG.PSU__IRQ_P2F_APM_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_COMM__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CPUMNT__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CTI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_EXTERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_L2ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_PMU__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_REGS__INT {0} \
    CONFIG.PSU__IRQ_P2F_ATB_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_CLKMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_CSUPMU_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_DDR_SS__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPDMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPORT__INT {0} \
    CONFIG.PSU__IRQ_P2F_EFUSE__INT {0} \
    CONFIG.PSU__IRQ_P2F_ENT3_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_ENT3__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_ATB_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_FP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_GDMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPIO__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPU__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C1__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APM__INT {0} \
    CONFIG.PSU__IRQ_P2F_LP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_OCM_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_DMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_LEGACY__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSC__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSI__INT {0} \
    CONFIG.PSU__IRQ_P2F_PL_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_QSPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE0_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE1_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_PERMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_ALARM__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_SECONDS__INT {0} \
    CONFIG.PSU__IRQ_P2F_SATA__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO0_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO0__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1__INT {0} \
    CONFIG.PSU__IRQ_P2F_SPI1__INT {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_UART1__INT {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_PMU_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_FPD_SMMU__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_PPD_CCI__INT {0} \
    CONFIG.PSU__L2_BANK0__POWER__ON {1} \
    CONFIG.PSU__LPDMA0_COHERENCY {0} \
    CONFIG.PSU__LPDMA1_COHERENCY {0} \
    CONFIG.PSU__LPDMA2_COHERENCY {0} \
    CONFIG.PSU__LPDMA3_COHERENCY {0} \
    CONFIG.PSU__LPDMA4_COHERENCY {0} \
    CONFIG.PSU__LPDMA5_COHERENCY {0} \
    CONFIG.PSU__LPDMA6_COHERENCY {0} \
    CONFIG.PSU__LPDMA7_COHERENCY {0} \
    CONFIG.PSU__LPD_SLCR__CSUPMU_WDT_CLK_SEL__SELECT {APB} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__MAXIGP0__DATA_WIDTH {32} \
    CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
    CONFIG.PSU__M_AXI_GP0_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP1_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP2_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__NAND__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__NAND__READY_BUSY__ENABLE {0} \
    CONFIG.PSU__NUM_FABRIC_RESETS {2} \
    CONFIG.PSU__OCM_BANK0__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK1__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK2__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK3__POWER__ON {1} \
    CONFIG.PSU__OVERRIDE_HPX_QOS {0} \
    CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
    CONFIG.PSU__PCIE__ACS_VIOLAION {0} \
    CONFIG.PSU__PCIE__AER_CAPABILITY {0} \
    CONFIG.PSU__PCIE__CLASS_CODE_BASE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x04} \
    CONFIG.PSU__PCIE__DEVICE_ID {0xD021} \
    CONFIG.PSU__PCIE__INTX_GENERATION {0} \
    CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
    CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {1} \
    CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {0} \
    CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
    CONFIG.PSU__PCIE__REVISION_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {} \
    CONFIG.PSU__PCIE__VENDOR_ID {} \
    CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PL_CLK0_BUF {TRUE} \
    CONFIG.PSU__PL_CLK1_BUF {TRUE} \
    CONFIG.PSU__PL_CLK2_BUF {TRUE} \
    CONFIG.PSU__PL__POWER__ON {1} \
    CONFIG.PSU__PMU_COHERENCY {0} \
    CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
    CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
    CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
    CONFIG.PSU__PMU__GPI0__ENABLE {1} \
    CONFIG.PSU__PMU__GPI0__IO {MIO 26} \
    CONFIG.PSU__PMU__GPI1__ENABLE {0} \
    CONFIG.PSU__PMU__GPI2__ENABLE {0} \
    CONFIG.PSU__PMU__GPI3__ENABLE {0} \
    CONFIG.PSU__PMU__GPI4__ENABLE {0} \
    CONFIG.PSU__PMU__GPI5__ENABLE {1} \
    CONFIG.PSU__PMU__GPI5__IO {MIO 31} \
    CONFIG.PSU__PMU__GPO0__ENABLE {1} \
    CONFIG.PSU__PMU__GPO0__IO {MIO 32} \
    CONFIG.PSU__PMU__GPO1__ENABLE {1} \
    CONFIG.PSU__PMU__GPO1__IO {MIO 33} \
    CONFIG.PSU__PMU__GPO2__ENABLE {1} \
    CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
    CONFIG.PSU__PMU__GPO2__POLARITY {high} \
    CONFIG.PSU__PMU__GPO3__ENABLE {1} \
    CONFIG.PSU__PMU__GPO3__IO {MIO 35} \
    CONFIG.PSU__PMU__GPO3__POLARITY {low} \
    CONFIG.PSU__PMU__GPO4__ENABLE {0} \
    CONFIG.PSU__PMU__GPO5__ENABLE {0} \
    CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
    CONFIG.PSU__PRESET_APPLIED {1} \
    CONFIG.PSU__PROTECTION__DDR_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__ENABLE {0} \
    CONFIG.PSU__PROTECTION__FPD_SEGMENTS {SA:0xFD1A0000; SIZE:1280; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD000000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write;\
subsystemId:PMU Firmware| SA:0xFD010000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD020000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU\
Firmware| SA:0xFD030000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD040000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|\
SA:0xFD050000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD610000; SIZE:512; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD5D0000;\
SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|SA:0xFD1A0000 ; SIZE:1280; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem} \
    CONFIG.PSU__PROTECTION__LPD_SEGMENTS {SA:0xFF980000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFF5E0000; SIZE:2560; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write;\
subsystemId:PMU Firmware| SA:0xFFCC0000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFF180000; SIZE:768; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU\
Firmware| SA:0xFF410000; SIZE:640; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFFA70000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|\
SA:0xFF9A0000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|SA:0xFF5E0000 ; SIZE:2560; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem|SA:0xFFCC0000\
; SIZE:64; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem|SA:0xFF180000 ; SIZE:768; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem|SA:0xFF9A0000\
; SIZE:64; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem} \
    CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;1|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;1|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;1|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;1|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1}\
\
    CONFIG.PSU__PROTECTION__MASTERS_TZ {GEM0:NonSecure|SD1:NonSecure|GEM2:NonSecure|GEM1:NonSecure|GEM3:NonSecure|PCIe:NonSecure|DP:NonSecure|NAND:NonSecure|GPU:NonSecure|USB1:NonSecure|USB0:NonSecure|LDMA:NonSecure|FDMA:NonSecure|QSPI:NonSecure|SD0:NonSecure}\
\
    CONFIG.PSU__PROTECTION__OCM_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__PRESUBSYSTEMS {NONE} \
    CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;0|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;1|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;1|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;0|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1}\
\
    CONFIG.PSU__PROTECTION__SUBSYSTEMS {PMU Firmware:PMU} \
    CONFIG.PSU__PSS_ALT_REF_CLK__ENABLE {0} \
    CONFIG.PSU__PSS_ALT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__QSPI_COHERENCY {0} \
    CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {0} \
    CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
    CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 5} \
    CONFIG.PSU__QSPI__PERIPHERAL__MODE {Single} \
    CONFIG.PSU__REPORT__DBGLOG {0} \
    CONFIG.PSU__RPU_COHERENCY {0} \
    CONFIG.PSU__RPU__POWER__ON {1} \
    CONFIG.PSU__SATA__LANE0__ENABLE {0} \
    CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
    CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
    CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk2} \
    CONFIG.PSU__SAXIGP0__DATA_WIDTH {128} \
    CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
    CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
    CONFIG.PSU__SAXIGP6__DATA_WIDTH {128} \
    CONFIG.PSU__SD0_COHERENCY {0} \
    CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD0__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD0__CLK_50_DDR_ITAP_DLY {0x12} \
    CONFIG.PSU__SD0__CLK_50_DDR_OTAP_DLY {0x6} \
    CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x6} \
    CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
    CONFIG.PSU__SD0__GRP_POW__ENABLE {1} \
    CONFIG.PSU__SD0__GRP_POW__IO {MIO 23} \
    CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
    CONFIG.PSU__SD0__RESET__ENABLE {1} \
    CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
    CONFIG.PSU__SD1_COHERENCY {0} \
    CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD1__CLK_100_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_50_DDR_ITAP_DLY {0x3D} \
    CONFIG.PSU__SD1__CLK_50_DDR_OTAP_DLY {0x4} \
    CONFIG.PSU__SD1__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD1__CLK_50_SDR_OTAP_DLY {0x5} \
    CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
    CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
    CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \
    CONFIG.PSU__SD1__GRP_WP__ENABLE {0} \
    CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
    CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
    CONFIG.PSU__SPI0_LOOP_SPI1__ENABLE {0} \
    CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SPI1__GRP_SS0__IO {MIO 9} \
    CONFIG.PSU__SPI1__GRP_SS1__ENABLE {0} \
    CONFIG.PSU__SPI1__GRP_SS2__ENABLE {0} \
    CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SPI1__PERIPHERAL__IO {MIO 6 .. 11} \
    CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
    CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
    CONFIG.PSU__TCM0A__POWER__ON {1} \
    CONFIG.PSU__TCM0B__POWER__ON {1} \
    CONFIG.PSU__TCM1A__POWER__ON {1} \
    CONFIG.PSU__TCM1B__POWER__ON {1} \
    CONFIG.PSU__TESTSCAN__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRACE__INTERNAL_WIDTH {32} \
    CONFIG.PSU__TRACE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRISTATE__INVERTED {1} \
    CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
    CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC0__WAVEOUT__ENABLE {1} \
    CONFIG.PSU__TTC0__WAVEOUT__IO {EMIO} \
    CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC2__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC3__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__UART0_LOOP_UART1__ENABLE {0} \
    CONFIG.PSU__UART0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__UART1__BAUD_RATE {115200} \
    CONFIG.PSU__UART1__MODEM__ENABLE {0} \
    CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 36 .. 37} \
    CONFIG.PSU__USB0_COHERENCY {0} \
    CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
    CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
    CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk1} \
    CONFIG.PSU__USB1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
    CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
    CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
    CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
    CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
    CONFIG.PSU__USE_DIFF_RW_CLK_GP0 {0} \
    CONFIG.PSU__USE__ADMA {0} \
    CONFIG.PSU__USE__APU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__AUDIO {0} \
    CONFIG.PSU__USE__CLK {0} \
    CONFIG.PSU__USE__CLK0 {0} \
    CONFIG.PSU__USE__CLK1 {0} \
    CONFIG.PSU__USE__CLK2 {0} \
    CONFIG.PSU__USE__CLK3 {0} \
    CONFIG.PSU__USE__CROSS_TRIGGER {0} \
    CONFIG.PSU__USE__DDR_INTF_REQUESTED {0} \
    CONFIG.PSU__USE__DEBUG__TEST {0} \
    CONFIG.PSU__USE__EVENT_RPU {0} \
    CONFIG.PSU__USE__FABRIC__RST {1} \
    CONFIG.PSU__USE__FTM {0} \
    CONFIG.PSU__USE__GDMA {0} \
    CONFIG.PSU__USE__IRQ {0} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__USE__IRQ1 {1} \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__M_AXI_GP2 {1} \
    CONFIG.PSU__USE__PROC_EVENT_BUS {0} \
    CONFIG.PSU__USE__RPU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__RST0 {0} \
    CONFIG.PSU__USE__RST1 {0} \
    CONFIG.PSU__USE__RST2 {0} \
    CONFIG.PSU__USE__RST3 {0} \
    CONFIG.PSU__USE__RTC {0} \
    CONFIG.PSU__USE__STM {0} \
    CONFIG.PSU__USE__S_AXI_ACE {0} \
    CONFIG.PSU__USE__S_AXI_ACP {0} \
    CONFIG.PSU__USE__S_AXI_GP0 {1} \
    CONFIG.PSU__USE__S_AXI_GP1 {0} \
    CONFIG.PSU__USE__S_AXI_GP2 {1} \
    CONFIG.PSU__USE__S_AXI_GP3 {1} \
    CONFIG.PSU__USE__S_AXI_GP4 {0} \
    CONFIG.PSU__USE__S_AXI_GP5 {0} \
    CONFIG.PSU__USE__S_AXI_GP6 {1} \
    CONFIG.PSU__USE__USB3_0_HUB {0} \
    CONFIG.PSU__USE__USB3_1_HUB {0} \
    CONFIG.PSU__USE__VIDEO {0} \
    CONFIG.PSU__VIDEO_REF_CLK__ENABLE {0} \
    CONFIG.PSU__VIDEO_REF_CLK__FREQMHZ {33.333} \
    CONFIG.QSPI_BOARD_INTERFACE {custom} \
    CONFIG.SATA_BOARD_INTERFACE {custom} \
    CONFIG.SD0_BOARD_INTERFACE {custom} \
    CONFIG.SD1_BOARD_INTERFACE {custom} \
    CONFIG.SPI0_BOARD_INTERFACE {custom} \
    CONFIG.SPI1_BOARD_INTERFACE {custom} \
    CONFIG.SUBPRESET1 {Custom} \
    CONFIG.SUBPRESET2 {Custom} \
    CONFIG.SWDT0_BOARD_INTERFACE {custom} \
    CONFIG.SWDT1_BOARD_INTERFACE {custom} \
    CONFIG.TRACE_BOARD_INTERFACE {custom} \
    CONFIG.TTC0_BOARD_INTERFACE {custom} \
    CONFIG.TTC1_BOARD_INTERFACE {custom} \
    CONFIG.TTC2_BOARD_INTERFACE {custom} \
    CONFIG.TTC3_BOARD_INTERFACE {custom} \
    CONFIG.UART0_BOARD_INTERFACE {custom} \
    CONFIG.UART1_BOARD_INTERFACE {custom} \
    CONFIG.USB0_BOARD_INTERFACE {custom} \
    CONFIG.USB1_BOARD_INTERFACE {custom} \
  ] $zynq_processing_system


  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_dma/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_hp0/S00_AXI]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_dma/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_hp0/S01_AXI]
  connect_bd_intf_net -intf_net S02_AXI_1 [get_bd_intf_pins axi_dma/M_AXI_SG] [get_bd_intf_pins axi_interconnect_hp0/S02_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins hier_dpu/S_AXI] [get_bd_intf_pins zynq_processing_system/M_AXI_HPM0_LPD]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins system_register/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports gpio_generic] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_interconnect_hp0_M00_AXI [get_bd_intf_pins axi_interconnect_hp0/M00_AXI] [get_bd_intf_pins zynq_processing_system/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M00_AXI [get_bd_intf_pins axi_dma/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_master_lpd/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M01_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins axi_interconnect_master_lpd/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M02_AXI [get_bd_intf_pins axi_interconnect_master_lpd/M02_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M03_AXI [get_bd_intf_pins axi_interconnect_master_lpd/M03_AXI] [get_bd_intf_pins ps_host_if_0/s_axi_lite]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M04_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_interconnect_master_lpd/M04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M05_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_master_lpd/M05_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M06_AXI [get_bd_intf_pins axi_interconnect_master_lpd/M06_AXI] [get_bd_intf_pins axis_tkeep_handler_0/s_axi_lite]
  connect_bd_intf_net -intf_net axi_interconnect_master_lpd_M07_AXI [get_bd_intf_pins axi_interconnect_master_lpd/M07_AXI] [get_bd_intf_pins event_stream_smart_t_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axis_tkeep_handler_0_m_axis [get_bd_intf_pins axis_tkeep_handler_0/m_axis] [get_bd_intf_pins event_stream_smart_t_0/in_event_stream]
  connect_bd_intf_net -intf_net ccam5_csi_rx_1 [get_bd_intf_ports ccam5_csi_rx] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net event_stream_smart_t_0_out_event_stream [get_bd_intf_pins event_stream_smart_t_0/out_event_stream] [get_bd_intf_pins ps_host_if_0/s_axis]
  connect_bd_intf_net -intf_net hier_0_ccam5_i2c [get_bd_intf_ports ccam5_i2c] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net hier_dpu_M_AXI_HP0_FPD [get_bd_intf_pins hier_dpu/M_AXI_HP0_FPD] [get_bd_intf_pins zynq_processing_system/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net hier_dpu_M_AXI_HP1_FPD [get_bd_intf_pins hier_dpu/M_AXI_HP1_FPD] [get_bd_intf_pins zynq_processing_system/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net hier_dpu_M_AXI_LPD [get_bd_intf_pins hier_dpu/M_AXI_LPD] [get_bd_intf_pins zynq_processing_system/S_AXI_LPD]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins axis_tkeep_handler_0/s_axis] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out]
  connect_bd_intf_net -intf_net ps_host_if_0_m_axis [get_bd_intf_pins axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ps_host_if_0/m_axis]
  connect_bd_intf_net -intf_net zynq_processing_system_M_AXI_HPM0_FPD [get_bd_intf_pins axi_interconnect_master_lpd/S00_AXI] [get_bd_intf_pins zynq_processing_system/M_AXI_HPM0_FPD]

  # Create port connections
  connect_bd_net -net PL_PS_IRQ_dout [get_bd_pins PL_PS_IRQ/dout] [get_bd_pins zynq_processing_system/pl_ps_irq0]
  connect_bd_net -net aux_reset_in_1 [get_bd_pins ps_system_reset/aux_reset_in] [get_bd_pins ps_system_reset/dcm_locked] [get_bd_pins ps_system_reset/ext_reset_in] [get_bd_pins vcc_constant/dout]
  connect_bd_net -net axi_dma_mm2s_introut [get_bd_pins PL_PS_IRQ/In0] [get_bd_pins axi_dma/mm2s_introut]
  connect_bd_net -net axi_dma_s2mm_introut [get_bd_pins PL_PS_IRQ/In1] [get_bd_pins axi_dma/s2mm_introut]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins PL_PS_IRQ/In2] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net clk_wiz_0_mipi_dphy_clk_o [get_bd_pins core_clock_0/mipi_dphy_clk_o] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
  connect_bd_net -net hier_0_pl_resetn0 [get_bd_pins core_clock_0/resetn] [get_bd_pins zynq_processing_system/pl_resetn0]
  connect_bd_net -net hier_dpu_GHP_CLK_O [get_bd_pins hier_dpu/GHP_CLK_O] [get_bd_pins zynq_processing_system/saxi_lpd_aclk] [get_bd_pins zynq_processing_system/saxihp0_fpd_aclk] [get_bd_pins zynq_processing_system/saxihp1_fpd_aclk]
  connect_bd_net -net hier_dpu_INTR [get_bd_pins hier_dpu/INTR] [get_bd_pins zynq_processing_system/pl_ps_irq1]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_csirxss_csi_irq [get_bd_pins PL_PS_IRQ/In3] [get_bd_pins mipi_csi2_rx_subsyst_0/csirxss_csi_irq]
  connect_bd_net -net pipeline_system_reset_peripheral_reset [get_bd_pins event_stream_smart_t_0/srst] [get_bd_pins ps_system_reset/peripheral_reset]
  connect_bd_net -net ps_system_reset_interconnect_aresetn [get_bd_pins axi_interconnect_hp0/ARESETN] [get_bd_pins axi_interconnect_master_lpd/ARESETN] [get_bd_pins ps_system_reset/interconnect_aresetn]
  connect_bd_net -net ps_system_reset_peripheral_reset [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_dma/axi_resetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_interconnect_hp0/M00_ARESETN] [get_bd_pins axi_interconnect_hp0/S00_ARESETN] [get_bd_pins axi_interconnect_hp0/S01_ARESETN] [get_bd_pins axi_interconnect_hp0/S02_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M00_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M01_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M02_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M03_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M04_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M05_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M06_ARESETN] [get_bd_pins axi_interconnect_master_lpd/M07_ARESETN] [get_bd_pins axi_interconnect_master_lpd/S00_ARESETN] [get_bd_pins axis_tkeep_handler_0/aresetn] [get_bd_pins event_stream_smart_t_0/arst_n] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn] [get_bd_pins ps_host_if_0/aresetn] [get_bd_pins ps_system_reset/peripheral_aresetn]
  connect_bd_net -net rst_gen_ghp_peripheral_aresetn [get_bd_pins hier_dpu/GHP_RSTn] [get_bd_pins rst_gen_ghp/peripheral_aresetn]
  connect_bd_net -net rst_gen_reg_peripheral_aresetn [get_bd_pins hier_dpu/RSTn] [get_bd_pins hier_dpu/S_AXI_RSTn] [get_bd_pins rst_gen_reg/peripheral_aresetn]
  connect_bd_net -net top_kria_fan_en_b [get_bd_ports fan_en_b] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net zynq_processing_system_hier_emio_ttc0_wave_o [get_bd_pins xlslice_0/Din] [get_bd_pins zynq_processing_system/emio_ttc0_wave_o]
  connect_bd_net -net zynq_processing_system_pl_clk0 [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_dma/m_axi_mm2s_aclk] [get_bd_pins axi_dma/m_axi_s2mm_aclk] [get_bd_pins axi_dma/m_axi_sg_aclk] [get_bd_pins axi_dma/s_axi_lite_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_interconnect_hp0/ACLK] [get_bd_pins axi_interconnect_hp0/M00_ACLK] [get_bd_pins axi_interconnect_hp0/S00_ACLK] [get_bd_pins axi_interconnect_hp0/S01_ACLK] [get_bd_pins axi_interconnect_hp0/S02_ACLK] [get_bd_pins axi_interconnect_master_lpd/ACLK] [get_bd_pins axi_interconnect_master_lpd/M00_ACLK] [get_bd_pins axi_interconnect_master_lpd/M01_ACLK] [get_bd_pins axi_interconnect_master_lpd/M02_ACLK] [get_bd_pins axi_interconnect_master_lpd/M03_ACLK] [get_bd_pins axi_interconnect_master_lpd/M04_ACLK] [get_bd_pins axi_interconnect_master_lpd/M05_ACLK] [get_bd_pins axi_interconnect_master_lpd/M06_ACLK] [get_bd_pins axi_interconnect_master_lpd/M07_ACLK] [get_bd_pins axi_interconnect_master_lpd/S00_ACLK] [get_bd_pins axis_tkeep_handler_0/aclk] [get_bd_pins core_clock_0/clk_in1] [get_bd_pins event_stream_smart_t_0/clk] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk] [get_bd_pins ps_host_if_0/aclk] [get_bd_pins ps_system_reset/slowest_sync_clk] [get_bd_pins zynq_processing_system/maxihpm0_fpd_aclk] [get_bd_pins zynq_processing_system/pl_clk0] [get_bd_pins zynq_processing_system/saxihpc0_fpd_aclk]
  connect_bd_net -net zynq_ultra_ps_e_pl_clk0 [get_bd_pins hier_dpu/CLK] [get_bd_pins hier_dpu/S_AXI_CLK] [get_bd_pins rst_gen_reg/slowest_sync_clk] [get_bd_pins zynq_processing_system/maxihpm0_lpd_aclk] [get_bd_pins zynq_processing_system/pl_clk1]
  connect_bd_net -net zynq_ultra_ps_e_pl_clk1 [get_bd_pins hier_dpu/GHP_CLK_I] [get_bd_pins rst_gen_ghp/slowest_sync_clk] [get_bd_pins zynq_processing_system/pl_clk2]
  connect_bd_net -net zynq_ultra_ps_e_pl_resetn0 [get_bd_pins rst_gen_ghp/ext_reset_in] [get_bd_pins rst_gen_reg/ext_reset_in] [get_bd_pins zynq_processing_system/pl_resetn1]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_MM2S] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_MM2S] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_S2MM] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_S2MM] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_SG] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_SG] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x80000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs hier_dpu/DPUCZDX8G/S_AXI/reg0] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0xA1000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs axi_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA1010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA0040000 -range 0x00000080 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs axis_tkeep_handler_0/s_axi/reg0] -force
  assign_bd_address -offset 0xA0050000 -range 0x00000100 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs event_stream_smart_t_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00002000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA0030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_processing_system/Data] [get_bd_addr_segs ps_host_if_0/s_axi/Reg] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA0] [get_bd_addr_segs zynq_processing_system/SAXIGP2/HP0_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA0] [get_bd_addr_segs zynq_processing_system/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA0] [get_bd_addr_segs zynq_processing_system/SAXIGP2/HP0_LPS_OCM] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA0] [get_bd_addr_segs zynq_processing_system/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA1] [get_bd_addr_segs zynq_processing_system/SAXIGP3/HP1_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA1] [get_bd_addr_segs zynq_processing_system/SAXIGP3/HP1_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA1] [get_bd_addr_segs zynq_processing_system/SAXIGP3/HP1_LPS_OCM] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_DATA1] [get_bd_addr_segs zynq_processing_system/SAXIGP3/HP1_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_INSTR] [get_bd_addr_segs zynq_processing_system/SAXIGP6/LPD_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_INSTR] [get_bd_addr_segs zynq_processing_system/SAXIGP6/LPD_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_INSTR] [get_bd_addr_segs zynq_processing_system/SAXIGP6/LPD_LPS_OCM] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces hier_dpu/DPUCZDX8G/DPU0_M_AXI_INSTR] [get_bd_addr_segs zynq_processing_system/SAXIGP6/LPD_QSPI] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma/Data_MM2S] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_MM2S] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma/Data_S2MM] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_S2MM] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma/Data_SG] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma/Data_SG] [get_bd_addr_segs zynq_processing_system/SAXIGP0/HPC0_LPS_OCM]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""

