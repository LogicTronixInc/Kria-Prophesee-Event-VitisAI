#!/bin/bash
: ${FORMAT:="PSEE_EVT21"}

# Force load of tkeep handler driver, so that we don't get the pass-through driver
# probed on tkeep handler
#modprobe psee-tkeep-handler

# Load the FPGA
#xmutil unloadapp
#xmutil loadapp prophesee-kv260-imx636

# Wait long enough for the drivers to be probed
sleep 1

# Set the pipeline to run in $FORMAT (eg PSEE_EVT3)
media-ctl -V "'imx636 6-003c':0[fmt:$FORMAT/1280x720]"
media-ctl -V "'a0010000.mipi_csi2_rx_subsystem':1[fmt:$FORMAT/1280x720]"
media-ctl -V "'a0040000.axis_tkeep_handler':1[fmt:$FORMAT/1280x720]"
media-ctl -V "'a0050000.event_stream_smart_tra':1[fmt:$FORMAT/1280x720]"
# The config of the pipeline can be seen with `media-ctl -p`

# Force the sensor to be ON, so that Metavision can do register accesses on it
# Write "auto" to let the sensor be powered down when not streaming
#echo on > /sys/class/video4linux/v4l-subdev3/device/power/control

# run with
# MV_LOG_LEVEL=TRACE V4L2_HEAP=reserved  V4L2_SENSOR_PATH=/dev/v4l-subdev3 metavision_viewer
