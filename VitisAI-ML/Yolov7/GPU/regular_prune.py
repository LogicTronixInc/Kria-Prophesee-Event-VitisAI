from models import *
from models.experimental import attempt_load
# from utils.utils import *
import torch
import torch.nn as nn
import numpy as np
from copy import deepcopy
from test import test
from terminaltables import AsciiTable
import time
# from utils.utils import *
from utils.prune_utils import *
import os
import yaml


#Row
class opt():
    model_def = "cfg/training/yolov3.yaml"
    data_config = "data/coco.yaml"
    model = 'runs/train/yolov7-custom11/weights/last.pt'
    single_cls = False
    
#Specify GPU
# torch.cuda.set_device(2)
percent = 0.8
filter_switch=[8,16,32,64,128,256,512,1024]

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = attempt_load(opt.model, map_location=device)

# print(model)


module_list = nn.ModuleList(layer for layer in model.model)
# print(module_list)
# print(module_list[4])


with open(opt.data_config, 'r') as file:
    data_config = yaml.safe_load(file)

# print(data_config)
valid_path = data_config["val"]
class_names = data_config["names"]

eval_model = lambda model:test(data=opt.data_config, weights=opt.model, device = "cuda", opt=opt)

obtain_num_parameters = lambda model:sum([param.nelement() for param in model.parameters()])

#This should not be annotated, it will be recovered when it will be restored
with torch.no_grad():
    origin_model_metric = eval_model(module_list)[1].mean()
origin_nparameters = obtain_num_parameters(model)

# print(model.yaml)
CBL_idx, Conv_idx, prune_idx= parse_module_defs(model.yaml)
# print(CBL_idx)
# print(Conv_idx)
# print(prune_idx) -- > [0, 1, 2, 3, 4, 6, 7, 8, 9, 11, 13, 15, 17, 19, 20, 21, 22, 24, 26, 28, 30, 32, 33, 34, 35, 37, 39, 41, 43, 45, 46, 47, 48, 50, 52, 54, 56, 57, 58, 59, 60, 61, 63, 64, 66, 68, 69, 70, 71, 72, 73, 75, 77, 78, 79, 81, 82, 83, 84, 85, 86, 88, 90, 91, 92, 94, 95, 96, 97, 98, 99, 101]

# print(model)



#Copy all the α parameters of the BN layer that to be cut to the BN_WEIGHTS list
bn_weights = gather_bn_weights(module_list, prune_idx)
# print(len(bn_weights))
#torch.SORT returns a two -dimensional list. The first dimension is the list of value after sorting, and the second dimension is the index corresponding to the list after sorting
sorted_bn = torch.sort(bn_weights)[0]


#Avoid cutting off tThe minimum value of the maximum value of each BN layer is the upper limit of the thresholdll Channel(每个BN层的gamma的最大值的最小值即为阈值上限)
highest_thre = []
for idx in prune_idx:
    #.item()You can get the element value in the tensor
    highest_thre.append(module_list[idx].bn.weight.data.abs().max().item())
highest_thre = min(highest_thre)

# Find the corresponding percentage corresponding to the setting of Highest_thre
percent_limit = (sorted_bn==highest_thre).nonzero()/len(bn_weights)
# print(torch.mean(percent_limit).item())
print(f'Threshold should be less than {highest_thre:.4f}.')
print(f'The corresponding prune ratio is {torch.mean(percent_limit).item():.3f}.')


# This function is of great significance:
# ① Copy the original model with a deep copy and get the Model_copy
# ② In the Model_copy, the α parameter below the threshold in the BN layer is 0
# ③ In the BN layer, output y = α*x+β. Since the value of the α parameter is assigned to 0, the input is only added with one bias β β
# ④ It is amazing that in Network Slimming is to set the α parameters and β parameters of 0 in the Network Slimming. Only the α parameter is 0, but the effect is very good: In fact, in another paper, it has been mentioned that it can be mentioned first.Move the effect of the β parameter to
# The next layer of convolutional layer, then cut off the α parameters of this layer

# This function uses the simplest way, let us see how to quickly see the effect of pruning



def prune_and_eval(module_list, sorted_bn, percent=.0):
    module_list_copy = deepcopy(module_list)
    thre_index = int(len(sorted_bn) * percent)
    #Get the threshold of the α parameter, the channel corresponding to the α parameter that is less than this value, all cut off
    thre = sorted_bn[thre_index]

    print(f'Channels with Gamma value less than {thre:.4f} are pruned!')

    remain_num = 0
    for idx in prune_idx:

        bn_module = module_list_copy[idx].bn

        mask = obtain_bn_mask(bn_module, thre)
        mask_cnt=int(mask.sum())
        if mask_cnt==0:
            this_layer_sort_bn=bn_module.weight.data.abs().clone()
            sort_bn_values= torch.sort(this_layer_sort_bn)[0]
            bn_cnt=bn_module.weight.shape[0]
            this_layer_thre=sort_bn_values[bn_cnt-8]
            mask = obtain_bn_mask(bn_module, this_layer_thre)
        else:
            for i in range(len(filter_switch)):
                if mask_cnt<=filter_switch[i]:
                    mask_cnt=filter_switch[i]
                    break
            this_layer_sort_bn=bn_module.weight.data.abs().clone()
            sort_bn_values= torch.sort(this_layer_sort_bn)[0]
            bn_cnt=bn_module.weight.shape[0]
            this_layer_thre=sort_bn_values[bn_cnt-mask_cnt]
            mask = obtain_bn_mask(bn_module, this_layer_thre)
            

        remain_num += int(mask.sum())
        bn_module.weight.data.mul_(mask)

    with torch.no_grad():
        # mAP = eval_model(model_copy)[1].mean()
        mAP = eval_model(module_list_copy)[1].mean()

    print(f'Number of channels has been reduced from {len(sorted_bn)} to {remain_num}')
    print(f'Prune ratio: {1-remain_num/len(sorted_bn):.3f}')
    print(f'mAP of the pruned model is {mAP:.4f}')

    return thre


threshold = prune_and_eval(module_list, sorted_bn, percent)

#****************************************************************
#Although the effect after the pruning can be seen above, it does not generate the model structure after pruning, so the following code is to generate a new model structure and copy the old model parameters to the new model

#%%
def obtain_filters_mask(model, module_list, thre, CBL_idx, prune_idx):

    pruned = 0
    total = 0
    num_filters = []
    filters_mask = []
    #CBL_IDX stores all the convolution layers with BN (the front layer of the YOLO layer is not BN)
    for idx in CBL_idx:
        bn_module = module_list[idx].bn
        if idx in prune_idx:

            mask = obtain_bn_mask(bn_module, thre).cpu().numpy()

            mask_cnt=int(mask.sum())

            if mask_cnt==0:
                this_layer_sort_bn=bn_module.weight.data.abs().clone()
                sort_bn_values= torch.sort(this_layer_sort_bn)[0]
                bn_cnt=bn_module.weight.shape[0]
                this_layer_thre=sort_bn_values[bn_cnt-8]
                mask = obtain_bn_mask(bn_module, this_layer_thre).cpu().numpy()

            else:
                for i in range(len(filter_switch)):
                    if mask_cnt<=filter_switch[i]:
                        mask_cnt=filter_switch[i]
                        break
                this_layer_sort_bn=bn_module.weight.data.abs().clone()
                sort_bn_values= torch.sort(this_layer_sort_bn)[0]
                bn_cnt=bn_module.weight.shape[0]
                this_layer_thre=sort_bn_values[bn_cnt-mask_cnt]
                mask = obtain_bn_mask(bn_module, this_layer_thre).cpu().numpy()
            
            remain = int(mask.sum())
            pruned = pruned + mask.shape[0] - remain

            if remain == 0:
                print("Channels would be all pruned!")
                raise Exception

            print(f'layer index: {idx:>3d} \t total channel: {mask.shape[0]:>4d} \t '
                  f'remaining channel: {remain:>4d}')
        else:
            mask = np.ones(bn_module.weight.data.shape)
            remain = mask.shape[0]

        total += mask.shape[0]
        num_filters.append(remain)
        filters_mask.append(mask.copy())

    #Therefore, the prune_ratio here,The α parameter that needs to be cut/All α parameters in CBL_IDX
    prune_ratio = pruned / total
    print(f'Prune channels: {pruned}\tPrune ratio: {prune_ratio:.3f}')

    return num_filters, filters_mask

num_filters, filters_mask = obtain_filters_mask(model, module_list, threshold, CBL_idx, prune_idx)
# print(filters_mask)

#CBLIDX2MASK storage in CBL_IDX, the Mask corresponding to each layer of the BN layer
CBLidx2mask = {idx: mask for idx, mask in zip(CBL_idx, filters_mask)}

pruned_module_list = prune_model_keep_size(model, module_list, prune_idx, CBL_idx, CBLidx2mask)

# print(pruned_module_list)

with torch.no_grad():
    mAP = eval_model(pruned_module_list)[1].mean()
print('after prune_model_keep_size map is {}'.format(mAP))


#Module_defs that get the original model, and modify the number of convolution kernels in the DEFS
compact_module_defs = deepcopy(model.module_defs)
for idx, num in zip(CBL_idx, num_filters):
    assert compact_module_defs[idx]['type'] == 'convolutional'
    compact_module_defs[idx]['filters'] = str(num)



compact_model = Darknet([model.hyperparams.copy()] + compact_module_defs).to(device)
compact_nparameters = obtain_num_parameters(compact_model)

init_weights_from_loose_model(compact_model, pruned_model, CBL_idx, Conv_idx, CBLidx2mask)


random_input = torch.rand((16, 3, 416, 416)).to(device)

def obtain_avg_forward_time(input, model, repeat=200):

    model.eval()
    start = time.time()
    with torch.no_grad():
        for i in range(repeat):
            output = model(input)
    avg_infer_time = (time.time() - start) / repeat

    return avg_infer_time, output

pruned_forward_time, pruned_output = obtain_avg_forward_time(random_input, pruned_model)
compact_forward_time, compact_output = obtain_avg_forward_time(random_input, compact_model)



# Test the model And count the number of parameters of the modeling pruning on the test set, And count the number of parameters of the model
with torch.no_grad():
    compact_model_metric = eval_model(compact_model)


# Compare the changes in the number of parameters before and after pruning, changes in indicator performance
metric_table = [
    ["Metric", "Before", "After"],
    ["mAP", f'{origin_model_metric[1].mean():.6f}', f'{compact_model_metric[1].mean():.6f}'],
    ["Parameters", f"{origin_nparameters}", f"{compact_nparameters}"],
    ["Inference", f'{pruned_forward_time:.4f}', f'{compact_forward_time:.4f}']
]
print(AsciiTable(metric_table).table)



# Generate the CFG file after the pruning and save the model
pruned_cfg_name = opt.model_def.replace('/', f'/prune_{percent}_')
for item in compact_module_defs:
    if item['type']=='yolo':
        item['anchors']='10,13,  16,30,  33,23,  30,61,  62,45,  59,119,  116,90,  156,198,  373,326'

pruned_cfg_file = write_cfg(pruned_cfg_name, [model.hyperparams.copy()] + compact_module_defs)
print(f'Config file has been saved: {pruned_cfg_file}')

compact_model_name = 'weights/yolov3_coco_regular_pruning_'+str(percent)+'percent.weights'

save_weights(compact_model, path=compact_model_name)
print(f'Compact model has been saved: {compact_model_name}')



