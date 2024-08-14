
# Outlines

Download "DPUCZDX8G_VAI_v3.0" from here [[DPUCZDX8G_VAI_v3.0.tar.gz](https://www.xilinx.com/bin/public/openDownload?filename=DPUCZDX8G_VAI_v3.0.tar.gz)] and extract the tar file here in this directory: 

1. Have to update the "dpu_conf.vh"  inside **"DPUCZDX8G_VAI_v3.0/prj/Vitis"**. The dpu_conf included in this directory has URAM enabled configuration for consuming the available URAM on Kria K26 FPGA of KV260.

2. Replace prj_config_1dpu inside **"DPUCZDX8G_VAI_v3.0/prj/Vitis/config_file"** from the provided one here.
3. Also replace the "makefile" at your directory **"DPUCZDX8G_VAI_v3.0/prj/Vitis"**, this makefile hs updated the "single DPU configuration". As KV260 only support single DPU of 4096 we are doing this.

4. Now, run the make script.


