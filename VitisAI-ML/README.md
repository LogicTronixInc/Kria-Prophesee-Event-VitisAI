# Vitis AI and ML directory

In this directory we are having Yolov7 and Yolov4-tiny ML models, training scripts in GPU, Quantization/Compilation scripts for Vitis AI and then Kria-KV260 Board inference scripts. 

We are using **Vitis AI 3.5** for Model Quantization and Compilation. If you want to re-create these event ML development then it is recommended to have "Vitis AI GPU docker (3.5)" in your Ubuntu PC.

1. **Yolov7**\
In yolov7, we have the training GPU script of yolov7, quantization/compilation and board inference scripts. \
We are using Pytorch based yolov7 for this application. 

2. **Yolov7-tiny**\
As like Yolov7, we also have Yolov7-tiny, which is lighter than Yolov7 and also performs better than Yolov7. 

3. **Yolov4-tiny**\
We also have created Yolov4-tiny based Vitis AI resource for this Prophesee event ML application. In yolov4-tiny we have the necessary codes/scripts for training, quantization/compilation and board inference. \
We are using Tensorflow 2 based training approch for Yolov4-tiny. Tf2 will be converted into tf1 (.pb) and then we will quantize the model in Vitis AI docker.

4. **Dataset** \
We have used eTRAM Dataset for larger training in event dataset. \
More details of eTRAM dataset can be found at: https://eventbasedvision.github.io/eTraM/



 Thanks for going through this repo! \
 LogicTronix is AMD-Xilinx Partner for FPGA Design and ML Acceleration! \
 For any queries you can raise git issues or can write us at : info@logictronix.com!

