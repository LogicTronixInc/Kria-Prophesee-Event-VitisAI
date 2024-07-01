# VIVADO and Vitis Platform

1. **Vitis Platform and Overlay**
This directory consists of Vitis flow design resources as Vitis Hardware Platform, Platform file (usable platform), DPU and Accelerator Overlay files.\
The readily available this Kria-Ubuntu application uses the Vitis-flow of DPU+MIPI design files.


2. **VIVADO DPU TRD**
Initially we created DPU-TRD based in Prophesee VIVADO MIPI Pipeline for Camera capture. \
This flow can be used if you are quite used to with VIVADO flow and going to use these resoruces in Petalinux.\
While following VIVADO DPU TRD we need to use the DPU driver patch and enablement in Linux Kernel, so we only tested VIVADO flow based DPU and Prophesee MIPI Cam pipeline in "Kria-Petalinux" flow of design.



## Directory hierarchy

├── README.md \
├── Vitis-Platform-Overlay \
│   ├── Build-log \
│   ├── DPU-Overlay \
│   ├── Vitis-Platform \
│   └── Vivado-hardware-platform \
└── VIVADO-DPU-TRD \

Thanks for going through this Kria-App design.

