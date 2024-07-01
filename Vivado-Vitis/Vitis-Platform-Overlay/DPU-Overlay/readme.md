
Download "DPUCZDX8G_VAI_v3.0" from here and extract the tar file here in this directory: 

Have to update teh "dpu_conf.vh"  inside "DPUCZDX8G_VAI_v3.0/prj/Vitis". This dpu_conf has URAM enabled configuration for consuming the available URAM on Kria K26 FPGA of KV260.
Also replace the "makefile" at your directory "DPUCZDX8G_VAI_v3.0/prj/Vitis", this makefile hs updated the "single DPU configuration". As KV260 only support single DPU of 4096 we are doing this.
and run the make script.


