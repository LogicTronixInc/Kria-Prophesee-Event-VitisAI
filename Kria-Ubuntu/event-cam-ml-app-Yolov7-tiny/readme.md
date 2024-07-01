This application runs YoloV4 ML model on event data stream from raw file or mipi event camera connected to KV260 board.
## Running the application:
- Load the environment variables
```
export LD_LIBRARY_PATH=/usr/lib
export PYTHONPATH=/usr/lib/python3.10/site-packages:$PYTHONPATH
```
For Raw event file as input, run the following in the build directory:
```
./metavision_histo_viewer -i <.raw event file> -m <Yolov7_tiny_320.xmodel> -c 0.3 -x 3 -y 3
```

For event camera as input, run the following:
- Setup the Hardware overlay using `xmutil`
```
sudo xmutil unloadapp
sudo xmutil loadapp <firmware overlay with mipi and dpu>
```
- Initialize the camera by running `load.sh` script
- Enable the camera
```
echo on > /sys/class/video4linux/<v4l-subdevx>/device/power/control
```
- Run the application
```
MV_LOG_LEVEL=TRACE V4L2_HEAP=reserved  V4L2_SENSOR_PATH=/dev/<v4l-subdevX> ./metavision_histo_viewer -m <Yolov7_tiny_320.xmodel> -c 0.3 -x 3 -y 3
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
