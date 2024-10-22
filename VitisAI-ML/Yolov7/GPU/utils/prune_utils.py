import torch
from terminaltables import AsciiTable
from copy import deepcopy
import numpy as np
import torch.nn.functional as F


def get_sr_flag(epoch, sr):
    # return epoch >= 5 and sr
    return sr

def parse_module_defs3(module_defs):

    CBL_idx = []
    Conv_idx = []
    for i, module_def in enumerate(module_defs):
        if module_def['type'] == 'convolutional':
            if module_def['batch_normalize'] == '1':
                CBL_idx.append(i)
            else:
                Conv_idx.append(i)

    ignore_idx = set()

    ignore_idx.add(18)
    

    prune_idx = [idx for idx in CBL_idx if idx not in ignore_idx]

    return CBL_idx, Conv_idx, prune_idx
    
def parse_module_defs2(module_defs):

    CBL_idx = []
    Conv_idx = []
    shortcut_idx=dict()
    shortcut_all=set()
    for i, module_def in enumerate(module_defs):
        if module_def['type'] == 'convolutional':
            if module_def['batch_normalize'] == '1':
                CBL_idx.append(i)
            else:
                Conv_idx.append(i)

    ignore_idx = set()
    for i, module_def in enumerate(module_defs):
        if module_def['type'] == 'shortcut':
            identity_idx = (i + int(module_def['from']))
            if module_defs[identity_idx]['type'] == 'convolutional':
                
                #ignore_idx.add(identity_idx)
                shortcut_idx[i-1]=identity_idx
                shortcut_all.add(identity_idx)
            elif module_defs[identity_idx]['type'] == 'shortcut':
                
                #ignore_idx.add(identity_idx - 1)
                shortcut_idx[i-1]=identity_idx-1
                shortcut_all.add(identity_idx-1)
            shortcut_all.add(i-1)
    #上采样层前的卷积层不裁剪
    ignore_idx.add(84)
    ignore_idx.add(96)

    prune_idx = [idx for idx in CBL_idx if idx not in ignore_idx]

    return CBL_idx, Conv_idx, prune_idx,shortcut_idx,shortcut_all

def parse_module_defs(module_defs):
 
    CBL_idx = []
    Conv_idx = []
    i = 0
    for i in range(len(module_defs['backbone'])):
        backbone = module_defs['backbone']
        if backbone[i][2] == 'Conv': 
            if backbone[i][0] == -1:
                if backbone[i][1] == 1:
                    CBL_idx.append(i)
                else:
                    Conv_idx.append(i)
            else:
                CBL_idx.pop()
        else:
            CBL_idx.pop()


    for j in range(len(module_defs['head'])):
        head = module_defs['head']
        if head[j][2] == 'Conv': 
            if  backbone[i][0] == -1:
                if head[i][1] == 1:
                    CBL_idx.append(i+j+1)
                else:                
                    Conv_idx.append(i+j+1)

            else:
                CBL_idx.pop()
        else:
            CBL_idx.pop()

    prune_idx = [idx for idx in CBL_idx]
    print("Prune index", prune_idx)
    return CBL_idx, Conv_idx, prune_idx


def gather_bn_weights(module_list, prune_idx):

    size_list = [module_list[idx].bn.weight.data.shape[0] for idx in prune_idx]

    bn_weights = torch.zeros(sum(size_list))
    index = 0
    for idx, size in zip(prune_idx, size_list):
        bn_weights[index:(index + size)] = module_list[idx].bn.weight.data.abs().clone()
        index += size

    return bn_weights


def write_cfg(cfg_file, module_defs):

    with open(cfg_file, 'w') as f:
        for module_def in module_defs:
            f.write(f"[{module_def['type']}]\n")
            for key, value in module_def.items():
                if key != 'type':
                    f.write(f"{key}={value}\n")
            f.write("\n")
    return cfg_file


class BNOptimizer():

    @staticmethod
    def updateBN(sr_flag, module_list, s, prune_idx):
        if sr_flag:
            for idx in prune_idx:
                # Squential(Conv, BN, Lrelu)
                bn_module = module_list[idx][1]
                bn_module.weight.grad.data.add_(s * torch.sign(bn_module.weight.data))  # L1


def obtain_quantiles(bn_weights, num_quantile=5):

    sorted_bn_weights, i = torch.sort(bn_weights)
    total = sorted_bn_weights.shape[0]
    quantiles = sorted_bn_weights.tolist()[-1::-total//num_quantile][::-1]
    print("\nBN weights quantile:")
    quantile_table = [
        [f'{i}/{num_quantile}' for i in range(1, num_quantile+1)],
        ["%.3f" % quantile for quantile in quantiles]
    ]
    print(AsciiTable(quantile_table).table)

    return quantiles


def get_input_mask(module_defs, idx, CBLidx2mask):

    if idx == 0:
        return np.ones(3)

    if module_defs[idx - 1]['type'] == 'convolutional':
        return CBLidx2mask[idx - 1]
    elif module_defs[idx - 1]['type'] == 'shortcut':
        return CBLidx2mask[idx - 2]
    elif module_defs[idx - 1]['type'] == 'route':
        route_in_idxs = []
        for layer_i in module_defs[idx - 1]['layers'].split(","):
            if int(layer_i) < 0:
                route_in_idxs.append(idx - 1 + int(layer_i))
            else:
                route_in_idxs.append(int(layer_i))
        if len(route_in_idxs) == 1:
            return CBLidx2mask[route_in_idxs[0]]
        elif len(route_in_idxs) == 2:
            return np.concatenate([CBLidx2mask[in_idx - 1] for in_idx in route_in_idxs])
        else:
            print("Something wrong with route module!")
            raise Exception


def init_weights_from_loose_model(compact_model, loose_model, CBL_idx, Conv_idx, CBLidx2mask):

    for idx in CBL_idx:
        compact_CBL = compact_model.module_list[idx]
        loose_CBL = loose_model.module_list[idx]
        out_channel_idx = np.argwhere(CBLidx2mask[idx])[:, 0].tolist()

        compact_bn, loose_bn         = compact_CBL[1], loose_CBL[1]
        compact_bn.weight.data       = loose_bn.weight.data[out_channel_idx].clone()
        compact_bn.bias.data         = loose_bn.bias.data[out_channel_idx].clone()
        compact_bn.running_mean.data = loose_bn.running_mean.data[out_channel_idx].clone()
        compact_bn.running_var.data  = loose_bn.running_var.data[out_channel_idx].clone()

        input_mask = get_input_mask(loose_model.module_defs, idx, CBLidx2mask)
        in_channel_idx = np.argwhere(input_mask)[:, 0].tolist()
        compact_conv, loose_conv = compact_CBL[0], loose_CBL[0]
        tmp = loose_conv.weight.data[:, in_channel_idx, :, :].clone()
        compact_conv.weight.data = tmp[out_channel_idx, :, :, :].clone()

    for idx in Conv_idx:
        compact_conv = compact_model.module_list[idx][0]
        loose_conv = loose_model.module_list[idx][0]

        input_mask = get_input_mask(loose_model.module_defs, idx, CBLidx2mask)
        in_channel_idx = np.argwhere(input_mask)[:, 0].tolist()
        compact_conv.weight.data = loose_conv.weight.data[:, in_channel_idx, :, :].clone()
        compact_conv.bias.data   = loose_conv.bias.data.clone()


def prune_model_keep_size(model, module_list, prune_idx, CBL_idx, CBLidx2mask):

    pruned_model = deepcopy(model)
    pruned_module_list = deepcopy(module_list)
    
    for idx in prune_idx:
        # print("index", idx)
        if idx in [56,68,75,81,88,94,101]:
            continue
        mask = torch.from_numpy(CBLidx2mask[idx]).cuda()
        # print("mask", mask.shape)
        bn_module = pruned_module_list[idx].bn
        bn_module.weight.data.mul_(mask)
        # print(bn_module.bias.data.shape)
        activation = F.silu((1 - mask) * bn_module.bias.data)

        # The convolution layer in front of the two upper sampling layers
        next_idx_list = [idx + 1]
        # if idx == 79:
        #     next_idx_list.append(84)
        # elif idx == 91:
        #     next_idx_list.append(96)
        # print("mask",mask)
        for next_idx in next_idx_list:
            # print(pruned_module_list[next_idx])
            next_conv = pruned_module_list[next_idx].conv
            # print("next conv", next_conv)
            conv_sum = next_conv.weight.data.sum(dim=(2, 3))
            # print("shape",conv_sum.shape)
            # print("activation",activation.shape)
            # print("shape1",conv_sum.shape)
            activation = activation.reshape(-1,1)
            offset = conv_sum.matmul(activation).reshape(-1)
            # print("offset", offset.shape)
            if next_idx in CBL_idx:
                next_bn = pruned_module_list[next_idx].bn
                next_bn.running_mean.data.sub_(offset)
            # else:
            #     #It should be noted here that for ConvolutionNal, if there are BN, the convolutional layer does not use BIAS. If there is no BN, use BIAS
            #     next_conv.bias.data.add_(offset)

        bn_module.bias.data.mul_(mask)

    return pruned_module_list


def obtain_bn_mask(bn_module, thre):

    thre = thre.cuda()
    mask = bn_module.weight.data.abs().ge(thre).float()

    return mask
