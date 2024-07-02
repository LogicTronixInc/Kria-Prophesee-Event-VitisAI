

# This is Yolov7 C++ inference project for RGB Video(webm or other raw video) or Camera.

Prerequisite:
1. KV260 Board , power adapter, SD card with Vitis AI 3.0 board image.
2. USB Camera - logitech camera of 720p or 1080p. We are using logitech C525 USB for this demo.

## For running this in Kria-Petalinux (Vitis AI 3.0 Boot image), follow these steps:

1. Download this Zip file(yolov7_cpp_new.zip) in Host PC.
2. Copy it to KV260 Board (Vitis AI Image 3.0 version) using scp command.
3. Extract the Zip file on the board.

4. Goto "yolov7_cpp_new" and run:

./yolov7_cpp_new
- it will show you inference run sequence like:  <application> <video_file> <xmodel>

5. For Camera based inference, you can run:
./yolov7_cpp_new /dev/video0 ./Yolov7_320_rgb.xmodel


## For running in Kria-Ubuntu
1. Boot the KV260-Ubuntu, load the firmware (smartcam firmware or our firmware)
2. Run docker command, smartcam or our docker image.
3. Now wget this repo inside the docker.
4. Extract the "yolov7_cpp_new.zip"
5. Goto "yolov7_cpp_new" and run the application.


Thanks for following this Kria-App! 
