# Float model 

# Quantized
* nndct_823_r1 --> not converted to hard_sigmoid
* nndct_828_r2 --> converted to hard sigmoid

* quantize_result --> [VAIQ_WARN][QUANTIZER_TORCH_REPLACE_SILU]: SiLU has been replaced by Hardswish.

# Compile
* Compiled_823_r1 --> Use nndct_823_r1, hence more layers thrown to CPU
* Compiled_828_r2 --> Use nndct_828_r2, hence lesser layers thrown to CPU
