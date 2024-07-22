# Kria-Petalinux

## Getting Started Guide
Follow this [Getting started for running event camera ML application in Petalinux 2022.pdf](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/Kria-Petalinux/Getting%20started%20for%20running%20event%20camera%20ML%20application%20in%20Petalinux%202022.pdf) for easy and fast bring up of this Kria Application in Petalinux.

## Petalinux Building Event Camera Application from scratch
For building Kria Application along with Petalinux image from BSP, follow this [Building Prophesee Event Camera Application in Petalinux.pdf](https://github.com/LogicTronixInc/Kria-Prophesee-Event-VitisAI/blob/main/Kria-Petalinux/Building%20Prophesee%20Event%20Camera%20Application%20in%20Petalinux.pdf) document. 

## Additional details
1. **BSP-WIC** \
Here we have the ready to build Petalinux BSP and ready to test WIC image for KV260.
- If you want to create the Petalinux project from scratch then you have to copy the "recipes" from "ZCU102-DPU-BSP" project and also configure the DPU driver at petalinux kernel config as mentioned here in this tutorial: \
https://www.hackster.io/LogicTronix/kria-kr260-dpu-trd-vivado-flow-vitis-ai-3-0-tutorial-0085fd#toc-c--petalinux-project-creation--configuration-and-build-2
 

2. **Device Driver**\
We have included the readme document about how to get the device drivers from Prophesee. \
Prophesee has released the drivers at the github: 
- https://github.com/prophesee-ai/zynq-video-drivers 
- https://github.com/prophesee-ai/linux-sensor-drivers


3. **Frimware**\
You can find the ready to run firmware.
These firmware are based on VIVADO-DPU-TRD. \
Though Vitis flow firmware can also be used in Petalinux.

    Firmware can be used from "/Kria-Ubuntu/Firmwares/" directory to!

4. **Build and Test Log**\
We have provided the build log of petalinux and testing log while testing the firmware or app in KV260.

For furthermore suport or issues , please contact us at : info@logictronix.com! 

Thanks for going through this Kria-App design.

