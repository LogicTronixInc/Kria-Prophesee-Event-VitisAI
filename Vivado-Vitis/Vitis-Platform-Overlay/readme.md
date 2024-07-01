## Steps to Follow for Vitis Platform and DPU Overlay

Download "DPUCZDX8G_VAI_v3.0" from here and extract the tar file here in this directory: 

Have to update teh "dpu_conf.vh"  inside "DPUCZDX8G_VAI_v3.0/prj/Vitis". This dpu_conf has URAM enabled configuration for consuming the available URAM on Kria K26 FPGA of KV260.
Also replace the "makefile" at your directory "DPUCZDX8G_VAI_v3.0/prj/Vitis", this makefile has updated the "single DPU configuration". As KV260 only support single DPU of 4096 we are doing this.
and run the make script.


Follow the build log attached here with or follow the reame.md from "DPUCZDX8G_VAI_v3.0/prj/Vitis".

### In the terminal, you have to do:

1. source XRT: source /opt/xilinx/xrt/setup.sh  and Source Vitis : source ~/tools/Xilinx/2022_2/Vivado/2022.2/settings64.sh . If you dont have XRT then you can setup via github link: or can download the Ubuntu version specific one from here:
2. Download the "Zynqmp-common" from petalinux page and do: export EDGE_COMMON_SW=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260_vitis_platform/xilinx-zynqmp-common-v2022.2
3. do: export SDX_PLATFORM=/home/logictronix03/Downloads/kk/June9-2024-kv260-platform/kv260-ppse-hardware-platform/kv260-pppse-dpu-vitis-flow-J10/kv260_ppse_custom/export/kv260_ppse_custom/kv260_ppse_custom.xpfm 

4. Then run: make all KERNEL=DPU DEVICE=KV260




5. Based on the PC config (CPU/RAM) this build may take from 15min to an hour or so.
At the end of build completion, you will get SD_card not a directory like error , you can skip that.
cp ./binary_*/link/vivado/vpl/prj/prj*/sources_1/bd/*/hw_handoff/*.hwh ./binary_*/sd_card
cp: target './binary_*/sd_card' is not a directory
make: *** [Makefile:112: package] Error 1


Above error occurred cause we are not going to create sd_card image from this make process. As KV260 follows "FPGA manger or DFX Manager or XMUTI utility" to load the "firmware(BIN, XCLBIN, JSON, DTBO) in Kria-Ubuntu we dont need "SD_Boot Image".
