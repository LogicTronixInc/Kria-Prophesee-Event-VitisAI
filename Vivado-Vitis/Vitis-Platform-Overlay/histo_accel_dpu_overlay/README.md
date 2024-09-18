# Histoframe Acceleration along with DPU Overlay design
In general, histoframe generation is done from Meta-Vision inside the PS application. That PS-based histoframe generation is generating significant latency, for which this accelerator can improve.\
In this directory, we are having histoframe acceleration, which is implemented in Vitis HLS and we will generate this accelerator along with DPU to achieve better performance.\
\
To generate this design, please go inside this directory ***./accelerated_app/apps/histoframe/build_flow/DPUCZDX8G_kv260***  
and follow the README.\
\
**Note:** This project acceleration is based on WAA-TRD of Vitis-AI [https://github.com/Xilinx/Vitis-AI/tree/3.0/examples/waa]