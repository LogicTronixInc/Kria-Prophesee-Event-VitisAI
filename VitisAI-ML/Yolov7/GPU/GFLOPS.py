import torchvision.models as models
import torch
from ptflops import get_model_complexity_info
import sys
from models.experimental import *

weight = './runs/yolov7.pt'
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

with torch.cuda.device(0):
#   net = models.densenet161()
  net = attempt_load(weight, map_location=device)
  macs, params = get_model_complexity_info(net, (3, 640,640), as_strings=True, print_per_layer_stat=True, verbose=True)
  print('{:<30}  {:<8}'.format('Computational complexity: ', macs))
  print('{:<30}  {:<8}'.format('Number of parameters: ', params))