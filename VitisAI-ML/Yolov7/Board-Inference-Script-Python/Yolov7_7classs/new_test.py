import argparse
import time
import cv2
import h5py
#import hdf5plugin
import numpy as np
# from utils.datasets import LoadStreams, LoadImages
# from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
#     scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
# from utils.plots import plot_one_box, viz_histo_binarized
# from utils.torch_utils import select_device, load_classifier, time_synchronized, TracedModel
# from utils.datasets import letterbox
BG_COLOR = np.array([30, 37, 52], dtype=np.uint8)
POS_COLOR = np.array([216, 223, 236], dtype=np.uint8)
NEG_COLOR = np.array([64, 126, 201], dtype=np.uint8)
def letterbox_new(img, new_shape=(640, 640), color=(114, 114, 114), auto=True, scaleFill=False, scaleup=True, stride=32):
    # Resize and pad image while meeting stride-multiple constraints
    shape = img.shape[:2]  # current shape [height, width]
    if isinstance(new_shape, int):
        new_shape = (new_shape, new_shape)

    # Scale ratio (new / old)
    r = min(new_shape[0] / shape[0], new_shape[1] / shape[1])
    if not scaleup:  # only scale down, do not scale up (for better test mAP)
        r = min(r, 1.0)

    # Compute padding
    ratio = r, r  # width, height ratios
    new_unpad = int(round(shape[1] * r)), int(round(shape[0] * r))
    dw, dh = new_shape[1] - new_unpad[0], new_shape[0] - new_unpad[1]  # wh padding
    if auto:  # minimum rectangle
        dw, dh = np.mod(dw, stride), np.mod(dh, stride)  # wh padding
    elif scaleFill:  # stretch
        dw, dh = 0.0, 0.0
        new_unpad = (new_shape[1], new_shape[0])
        ratio = new_shape[1] / shape[1], new_shape[0] / shape[0]  # width, height ratios

    dw /= 2  # divide padding into 2 sides
    dh /= 2

    if shape[::-1] != new_unpad:  # resize
        img = cv2.resize(img, new_unpad, interpolation=cv2.INTER_LINEAR)
    top, bottom = int(round(dh - 0.1)), int(round(dh + 0.1))
    left, right = int(round(dw - 0.1)), int(round(dw + 0.1))
    img = cv2.copyMakeBorder(img, top, bottom, left, right, cv2.BORDER_CONSTANT, value=color)  # add border
    return img, ratio, (dw, dh)



def viz_histo_binarized_new(im):
    """
    Visualize binarized histogram of events

    Args:
        im (np.ndarray): Array of shape (2,H,W)

    Returns:
        output_array (np.ndarray): Array of shape (H,W,3)
    """
    img = np.full(im.shape[-2:] + (3,), BG_COLOR, dtype=np.uint8)
    y, x = np.where(im[0] > 0)
    img[y, x, :] = POS_COLOR
    y, x = np.where(im[1] > 0)
    img[y, x, :] = NEG_COLOR
    return img

def detect(save_img=True):
    source = "moorea_2019-01-30_000_td_500000_10500000.h5"
    stride = 32
    imgsz = 640

    events_file = h5py.File(source, "r+")
    print("events_file")
    print(events_file)
    print("stride \n\n",stride)
    print("imgsz",imgsz)

    t0 = time.time()
    for idx in range(len(events_file['data'])):
        img = np.transpose(events_file['data'][idx], (1, 2, 0))
        img = letterbox_new(img, imgsz, stride=stride)[0].transpose(2, 0, 1)
        im0 = viz_histo_binarized_new(img.copy())
        height, width, _ = im0.shape
        name_one = ("output_frame/{}.jpg").format(idx)
        cv2.imwrite(name_one,(cv2.cvtColor(im0, cv2.COLOR_RGB2BGR)))




if __name__ == '__main__':
     detect()
