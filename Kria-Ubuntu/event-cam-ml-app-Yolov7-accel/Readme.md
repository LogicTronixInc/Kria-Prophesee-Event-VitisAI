This application runs YoloV4 ML model on event data stream from raw file or mipi event camera connected to KV260 board.
## Running the application:
- Load the environment variables
```
export LD_LIBRARY_PATH=/usr/lib
export PYTHONPATH=/usr/lib/python3.10/site-packages:$PYTHONPATH
```
- Setup the Hardware overlay using `xmutil`
```
sudo xmutil unloadapp
sudo xmutil loadapp <kv260-psee-dpu-accel>
```
For Raw event file as input, run the following in the build directory:
```
export XLNX_VART_FIRMWARE=/lib/firmware/xilinx/kv260-psee-dpu-accel/kv260-psee-dpu-accel.xclbin
./metavision_histo_viewer  <event_yolov7_accel.xmodel>  <raw event file>
```

For event camera as input, run the following:

- Initialize the camera by running `load.sh` script
- Enable the camera
```
echo on > /sys/class/video4linux/<v4l-subdevx>/device/power/control
```
- Run the application
```
export XLNX_VART_FIRMWARE=/lib/firmware/xilinx/kv260-psee-dpu-accel/kv260-psee-dpu-accel.xclbin
MV_LOG_LEVEL=TRACE V4L2_HEAP=reserved  V4L2_SENSOR_PATH=/dev/<v4l-subdevX> ./metavision_histo_viewer <event_yolov7_accel.xmodel> 0
```

## Compiling the application
Run following commands in the application directory:
```
mkdir build
cd build
cmake ..
make
```
This will create `metavision_histo_viewer` in the build directory.
