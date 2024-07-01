# Acknowledgement
This Kria-App is developed by LogicTronix in coordination with Prophesee and AMD!\
Thanks to AMD and Prophesee Team!

# Kria-Prophesee-Event-VitisAI
This repository consists of all the resources for running Prophesee CCAM5 event camera with Vitis AI ML application in KV260.


## Easy Running this Application
For easy running of this application , please follow :\
 **[GettingStartedGuide- Downloading and Loading the Application Firmware in KV260.pdf](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/Documentations/GettingStartedGuide-%20Downloading%20and%20Loading%20the%20Application%20Firmware%20in%20KV260.pdf)** from "Kria-Prophesee-Event-VitisAI/tree/main/Documentations"!

###General Setup of Prophesee CCAM5 Event Camera with Kria KV260
[KV260-Prophesee-CCAM5](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/images/Prophesee-Event-Cam-Kria-App.jpg)

##Re-create the Application
We have provided the "Detail Design Guides" for recreating different section of this Kria-App, follow those form here - [Link](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/tree/main/Documentations#re-create-this-kria-application)\ 
*For re-creation you need to have "AMD Vitis 2022.2 ,XRT 2022.2 and Petalinux 2022.2 (optional)" tools.*



## Directory hierarchy

├── Documentations \
├── images \
│   └── README.md \
├── Kria-Petalinux \
├── Kria-Ubuntu \
│   ├── Firmwares \
│   │   └── psee-vitis-mipi-dpu \
│   │       ├── psee-vitis-mipi-dpu-b4096.bin \
│   │       ├── psee-vitis-mipi-dpu-ubuntu.dtbo \
│   │       └── shell.json \
│   ├── Prophesee-device-drivers \
│   │   └── compiled_kernel_modules \
│   │       ├── imx636.ko \
│   │       ├── install.sh \
│   │       ├── psee-csi2rxss.ko \
│   │       ├── psee-streamer.ko \
│   │       ├── psee-tkeep-handler.ko \
│   │       └── psee-video.ko \
│   └── scripts \
│       ├── install_psee_drivers.sh \
│       └── install_updated_linux_kernel.sh \
├── README.md \
├── VitisAI-ML \
│   ├── Dataset \
│   ├── images \
│   ├── README.md \
│   ├── Yolov4tiny \
│   └── Yolov7 \
└── Vivado-Vitis \
    ├── README.md \
    ├── Vitis-Platform-Overlay \
    │   ├── Build-log \
    │   ├── DPU-Overlay \
    │   ├── Vitis-Platform \
    │   └── Vivado-hardware-platform \
    └── VIVADO-DPU-TRD \

\
Thanks for going through this repo! \
 **LogicTronix is AMD-Xilinx Partner for FPGA Design and ML Acceleration!** \
 For any queries you can raise git issues or can write us at : info@logictronix.com!
