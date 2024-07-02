# Prophesee-vitis-ai-ml-Kria-KV260-Petalinux

## Prerequisite:
1. Kria KV260 Board
2. Power adapter and USB cable (for UART)
3. 16GB SD card (for burning image)
4. Ethernet cable (for internet connection)
5. Monitor (1080p or higher,  HDMI or DP - any)


## Steps to run demo in KV260
1. Download and prepare(burn with BalenaEitcher) **KV260 vitis-ai 3.0 image** by following this:
   https://xilinx.github.io/Vitis-AI/3.0/html/docs/quickstart/mpsoc.html#setup-the-target .\
   \
   You have to connect KV260 with Monitor, connect ethernet cable between KV260 and Switch/Router, connect Mouse and keyboard with KV260 (mouse and keyboard are needed for typing command in KV260 terminal).
2. Boot up KV260 with above image. You will see boot messages in display connected to KV260 board.

3. Clone this github repo on your PC and copy **yolov7_april5_demo** into KV260 board by following SCP command:\
 ` scp -r yolov7_april5_demo root@ip_address:Vitis-AI/examples/vai_runtime ` \
\
 In above command replace ip_address with board ip address, you can find board ip address by `ifconfig` command in KV260 Board terminal (type `ifconfig` command in KV260 board terminal using keyboard). 

4. Run the python command: \
    ` python3 dpu_test_h5_resize.py Yolov7_kv260_detection_3_19.xmodel recording_2023-09-22_13-28-55.h5 `

### Output will display on  monitor connected with KV260. 

5. We also have created a short video record of "Yolov7 model running in KV260" and uploaded here (unlisted, accessible only with the link): \
   https://youtu.be/9pYPPDTyUVw

*** Demo Completes ***  
