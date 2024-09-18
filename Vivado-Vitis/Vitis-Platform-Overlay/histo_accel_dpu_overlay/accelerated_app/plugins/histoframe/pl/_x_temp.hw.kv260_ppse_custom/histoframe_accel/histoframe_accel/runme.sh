#!/bin/sh

# 
# v++(TM)
# runme.sh: a v++-generated Runs Script for UNIX
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/media/abhidan/sata/2022_2/Xilinx/Vitis_HLS/2022.2/bin:/media/abhidan/sata/2022_2/Xilinx/Vitis/2022.2/bin:/media/abhidan/sata/2022_2/Xilinx/Vitis/2022.2/bin
else
  PATH=/media/abhidan/sata/2022_2/Xilinx/Vitis_HLS/2022.2/bin:/media/abhidan/sata/2022_2/Xilinx/Vitis/2022.2/bin:/media/abhidan/sata/2022_2/Xilinx/Vitis/2022.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/media/abhidan/sata/temp/acceleration_2/Vitis-AI-3.0/examples/waa/plugins/histoframe/pl/_x_temp.hw.kv260_ppse_custom/histoframe_accel/histoframe_accel'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vitis_hls -f histoframe_accel.tcl -messageDb vitis_hls.pb
