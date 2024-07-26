# Acknowledgement
This Kria-App is developed by LogicTronix in coordination with Prophesee and AMD!\
**Thanks to AMD and Prophesee Team!**

# Kria-Prophesee-Event-VitisAI
This repository consists of all the resources for running Prophesee CCAM5 event camera with Vitis AI ML application in KV260.


## Easy Running this Application
For easy running of this application , please follow :\
 **[GettingStartedGuide- Downloading and Loading the Application Firmware in KV260.pdf](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/Documentations/GettingStartedGuide-%20Downloading%20and%20Loading%20the%20Application%20Firmware%20in%20KV260.pdf)**!

### General Setup of Prophesee CCAM5 Event Camera with Kria KV260
![KV260-Prophesee-CCAM5](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/images/Prophesee-Event-Cam-Kria-App.jpg "KV260-Prophesee-CCAM5")

### How event ML is different than RGB one?
![Event-vs-RGB-ML](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/images/event-vs-RGB-camera_ML.png "Event-vs-RGB-ML")

### Event ML - Video Demo
[Kria Prophesee App - Demo(YouTube)](https://youtu.be/qAaae-wooaA?si=Z--ox98mg_W4XOif)

## Re-create the Application
We have provided the "Detail Design Guides" for recreating different section of this Kria-App, follow those from here - [Link](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/tree/main/Documentations#re-create-this-kria-application) 

**For re-creation you need to have following tools:**
- AMD Vitis 2022.2 ,
- XRT 2022.2 and 
- Petalinux 2022.2 (optional).



## Directory hierarchy

├── Documentations \
│   ├── Detail-Design-Guide-01-Creating psee-ML-DPU Docker image.pdf \
│   ├── Detail-Design-Guide-02-Cross Compiling Ubuntu Kernel and Psee drivers.pdf \
│   ├── Detail-Design-Guide-03-Preparing Kria-App-Firmwares for KV260.pdf \
│   ├── Detail-Design-Guide-04-Yolo-and-VitisAI.pdf \
│   ├── Detail-Design-Guide-05-Vitis-Platform-DPU-Design.pdf \
│   ├── GettingStartedGuide- Downloading and Loading the Application Firmware in KV260.pdf\
│   └── README.md\
├── images\
│   ├── event-vs-RGB-camera_ML.png\
│   ├── Prophesee-Event-Cam-Kria-App.jpg\
│   └── README.md\
├── Kria-Petalinux\
│   ├── BSP-WIC\
│   ├── Build_and_Test_Log\
│   ├── Device-Driver\
│   ├── Firmware\
│   ├── Petalinux port for Prophesee Event camera with ML.pdf\
│   ├── README.md\
│   └── Yolo-Event-ML-Application\
├── Kria-Ubuntu\
│   ├── event-cam-ml-app-Yolov4-tiny\
│   ├── event-cam-ml-app-Yolov7\
│   ├── event-cam-ml-app-Yolov7-tiny\
│   ├── Firmwares\
│   ├── Prophesee-device-drivers\
│   ├── README.md\
│   └── scripts\
├── README.md\
├── VitisAI-ML\
│   ├── Dataset\
│   ├── images\
│   ├── README.md\
│   ├── Yolov4tiny\
│   └── Yolov7\
└── Vivado-Vitis\
    ├── images\
    ├── README.md\
    ├── Vitis-Platform-Overlay\
    └── VIVADO-DPU-TRD

Thanks for going through this repo! \
 **LogicTronix is AMD-Xilinx Partner for FPGA Design and ML Acceleration!** \
 For any queries you can raise git issues or can write us at : info@logictronix.com!
