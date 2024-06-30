# PTQ

* Run script: test_nndct_copy.py

### Calib step
python test_nndct_copy.py --quant_mode calib --nndct_convert_sigmoid_to_hsigmoid --nndct_convert_silu_to_hswish

### Test / deploy step
python test_nndct_copy.py --quant_mode test --nndct_convert_sigmoid_to_hsigmoid --nndct_convert_silu_to_hswish

To add weights --> from argument --weights <weight_path>

* Quantize Result --> nndct 

### Compile - For KV260
vai_c_xir --xmodel quantized_prophese/Model_0_int.xmodel --arch /opt/vitis_ai/compiler/arch/DPUCZDX8G/KV260/arch.json --net_name Yolov7_kv260_detection --output_dir ./KV260_detection_model

### Compile - For V70
vai_c_xir --xmodel ./nndct/Model_0_int.xmodel --arch /opt/vitis_ai/compiler/arch/DPUCV2DX8G/V70/arch.json --net_name Yolov7_v70 --output_dir ./V70