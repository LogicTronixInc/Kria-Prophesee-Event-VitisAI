import sys
import xir
import vart
import time
from typing import List

import numpy as np
import importlib
import cv2

from utils import YOLOPost, non_max_suppression


def runYolo(dpu_runner_tfYolo, image, ori_frame):

    #print("inside the run yolo..")
    inputTensors = dpu_runner_tfYolo.get_input_tensors()  #  get the model input tensor
    outputTensors = dpu_runner_tfYolo.get_output_tensors() # get the model ouput tensor
    print("output Tensors ",outputTensors)
    
    outputHeight_0 = outputTensors[0].dims[1]
    outputWidth_0 = outputTensors[0].dims[2]
    outputChannel_0 = outputTensors[0].dims[3]

    outputHeight_1 = outputTensors[1].dims[1]
    outputWidth_1 = outputTensors[1].dims[2]
    outputChannel_1 = outputTensors[1].dims[3]

    outputHeight_2 = outputTensors[2].dims[1]
    outputWidth_2 = outputTensors[2].dims[2]
    outputChannel_2 = outputTensors[2].dims[3]    

    # outputSize_0 = (outputHeight_0,outputWidth_0,outputChannel_0)
    #print("outputSize_0 ", outputSize_0)
    # outputSize_1 = (outputHeight_1,outputWidth_1,outputChannel_1)
    #print("outputSize_1 ", outputSize_1) 
    # outputSize_2 = (outputHeight_2,outputWidth_2,outputChannel_2)
    #print("outputSize_2 ", outputSize_2) 

    runSize = 1
    shapeIn = (runSize,) + tuple([inputTensors[0].dims[i] for i in range(inputTensors[0].ndim)][1:])
    #print("What shapeIn", shapeIn) 
    #print("InputTensor[0]: ", inputTensors[0])


    '''prepare batch input/output '''
    outputData = []
    inputData = []
    outputData.append(np.empty((runSize,outputHeight_0,outputWidth_0,outputChannel_0), dtype = np.float32, order = 'C'))
    outputData.append(np.empty((runSize,outputHeight_1,outputWidth_1,outputChannel_1), dtype = np.float32, order = 'C'))
    outputData.append(np.empty((runSize,outputHeight_2,outputWidth_2,outputChannel_2), dtype = np.float32, order = 'C'))
    inputData.append(np.empty((shapeIn), dtype = np.float32, order = 'C'))

    '''init input image to input buffer '''
    imageRun = inputData[0]
    print("image shape ",image.shape)
    imageRun[0,...] = image.reshape(inputTensors[0].dims[1],inputTensors[0].dims[2],inputTensors[0].dims[3])


    '''Execution'''
    #print("Execute async")
    start_time_exe = time.time()
    job_id = dpu_runner_tfYolo.execute_async(inputData,outputData)
    dpu_runner_tfYolo.wait(job_id)
    end_time_exe = time.time()
    model_time = end_time_exe - start_time_exe
    print("Execution Time: ", model_time)
    #print("Execution completed..")


    #print()
    #print("Shapes of output: ")
    #print(outputData[0].shape) 
    #print(outputData[1].shape) 
    #print(outputData[2].shape) 
    # Shapes of output: 
    # (1, 80, 80, 255)
    # (1, 40, 40, 255)
    # (1, 20, 20, 255)
    #print()
    #print("Input image shape: ", inputData[0].shape) 
    #print("Image shape[0]: ", inputData[0][0].shape) 


    '''Post Processing'''
    start_time_post = time.time()

    outputData[0] = np.transpose(outputData[0], (0,3,1,2))
    outputData[1] = np.transpose(outputData[1], (0,3,1,2))
    outputData[2] = np.transpose(outputData[2], (0,3,1,2))

    # Swap outputData[0] and outputData[2]
    outputData[0], outputData[2] = outputData[2], outputData[0]

    #print()
    #print("Shapes of output: ")
    #print(outputData[0].shape) 
    #print(outputData[1].shape) 
    #print(outputData[2].shape) 
    #print()
    # Shapes of output: 
    # (1, 255, 20, 20)
    # (1, 255, 40, 40)
    # (1, 255, 80, 80)

    # Get config
    params_path = "params.py"
    config = importlib.import_module(params_path[:-3]).TRAINING_PARAMS

    # YOLO loss with 3 scales
    yolo_losses = []
    for i in range(3):
        print("i value are ",i)
        yolo_losses.append(YOLOPost(config["yolo"]["anchors"][i],
                                    config["yolo"]["classes"], (config["img_w"], config["img_h"])))

    output_list = []
    for i in range(3):
        print("i value new",i)
        output_list.append(yolo_losses[i].forward(outputData[i]))
    output_con = np.concatenate(output_list, 1)

    #print(len(output_list))
    #print(output_list[0].shape) # ([1, 1200, 85]) | 20*20*3
    #print(output_list[1].shape) # ([1, 4800, 85]) | 40*40*3
    #print(output_list[2].shape) # ([1, 19200, 85]) | 80*80*3

    #print(len(output_con))
    #print(output_con.shape) # ([1, 25200, 85])

    batch_detections = non_max_suppression(output_con, config["yolo"]["classes"],
                                            conf_thres=config["confidence_threshold"],
                                            nms_thres=0.2)

    #print(batch_detections)
    end_time_post = time.time()
    postprocess_time = end_time_post - start_time_post
    print("Postprocessing Time: ", postprocess_time)


    '''Plot prediction with bounding box'''
    start_time_plot = time.time()
    classes = open(config["classes_names_path"], "r").read().split("\n")[:-1]
    #print(classes)

    for idx, detections in enumerate(batch_detections):
        if detections is not None:
            # ori_frame = cv2.imread(image_path)

            unique_labels = np.unique(detections[:, -1])
            n_cls_preds = len(unique_labels)
            bbox_colors = {int(cls_pred): (255,0,0) for cls_pred in unique_labels}
            
            for x1, y1, x2, y2, conf, cls_conf, cls_pred in detections:
                color = bbox_colors[int(cls_pred)]

                # Rescale coordinates to original dimensions
                ori_h, ori_w, _ = ori_frame.shape
                pre_h, pre_w = config["img_h"], config["img_w"]
                box_h = ((y2 - y1) / pre_h) * ori_h
                box_w = ((x2 - x1) / pre_w) * ori_w
                y1 = (y1 / pre_h) * ori_h
                x1 = (x1 / pre_w) * ori_w

                # Create a Rectangle patch
                cv2.rectangle(ori_frame, (int(x1), int(y1)), (int(x1 + box_w), int(y1 + box_h)), color, 2)

                # Add label
                label = classes[int(cls_pred)]
                cv2.putText(ori_frame, label, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

        # # Save generated image with detections
        # output_path = 'prediction.jpg'
        # cv2.imwrite(output_path, im)
        end_time_plot = time.time()
        plotting_time = end_time_plot - start_time_plot
        print("Plotting time: ", plotting_time)

        # Display image
        cv2.imshow("Prediction", ori_frame)
        cv2.imwrite("output_frame/10.jpg",ori_frame)
        cv2.waitKey(0)



def get_child_subgraph_dpu(graph: "Graph") -> List["Subgraph"]:
    assert graph is not None, "'graph' should not be None."

    root_subgraph = graph.get_root_subgraph() # Retrieves the root subgraph of the input 'graph'
    assert (root_subgraph
            is not None), "Failed to get root subgraph of input Graph object."
    
    if root_subgraph.is_leaf:
        return [] # If it is a leaf, it means there are no child subgraphs, so the function returns an empty list 
    
    child_subgraphs = root_subgraph.toposort_child_subgraph() # Retrieves a list of child subgraphs of the 'root_subgraph' in topological order
    assert child_subgraphs is not None and len(child_subgraphs) > 0

    return [
        # List comprehension that filters the child_subgraphs list to include only those subgraphs that represent DPUs
        cs for cs in child_subgraphs
        if cs.has_attr("device") and cs.get_attr("device").upper() == "DPU"
    ]


BG_COLOR = np.array([30, 37, 52], dtype=np.uint8)
POS_COLOR = np.array([216, 223, 236], dtype=np.uint8)
NEG_COLOR = np.array([64, 126, 201], dtype=np.uint8)
def letterbox_resize_opencv(original_image, target_size=(640,640), fill_color=(255, 255, 255)):
    original_height, original_width, _ = original_image.shape
    aspect_ratio = original_width / original_height

    # Calculate the new size while maintaining the aspect ratio
    if aspect_ratio > 1:
        new_width = target_size[0]
        new_height = int(new_width / aspect_ratio)
    else:
        new_height = target_size[1]
        new_width = int(new_height * aspect_ratio)

    # Resize the image with letterboxing
    resized_image = cv2.resize(original_image, (new_width, new_height))

    # Create a blank canvas of the target size
    canvas = np.zeros((target_size[1], target_size[0], 2), dtype=np.uint8)

    # Calculate the position to place the resized image in the center
    x_offset = (target_size[0] - new_width) // 2
    y_offset = (target_size[1] - new_height) // 2

    # Paste the resized image onto the center of the canvas
    canvas[y_offset:y_offset+new_height, x_offset:x_offset+new_width] = resized_image


    return canvas





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


def main(argv):
    g = xir.Graph.deserialize(argv[1]) # Deserialize the DPU graph
    subgraphs = get_child_subgraph_dpu(g) # Extract DPU subgraphs from the graph
    assert len(subgraphs) == 1  # only one DPU kernel

    """Creates DPU runner, associated with the DPU subgraph."""
    dpu_runners = vart.Runner.create_runner(subgraphs[0], "run")
    #print("DPU Runner Created")

    """Pre-processing"""
    start_time_pre = time.time()
    # image_path = argv[2]
    loaded_array = np.load(argv[2])
    stride = 32
    imgsz = 640
    img = letterbox_resize_opencv(loaded_array).astype(float)
        # img = letterbox_new(loaded_array, imgsz, stride=stride)[0].transpose(2, 0, 1)
        
    im0 = viz_histo_binarized_new(img.copy().transpose(2, 0, 1))
    im0 = cv2.cvtColor(im0, cv2.COLOR_RGB2BGR)
    # cv2.imshow("im0",im0)
    # cv2.waitKey(0)

    height, width, _ = im0.shape
    img /= 255.0 
    # image /= 255.0
    # end_time_pre = time.time()
    # preprocess_time = end_time_pre - start_time_pre
    # print("Preprocess Time: ", preprocess_time)

    """Assigns the runYolo function with corresponding arguments"""
    #print("runYolo -- main function intialize")
    runYolo(dpu_runners, img, im0)

    del dpu_runners
    #print("DPU runnerr deleted")



if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage : python3 dpu_inference.py <xmodel_file> <test_file>")
    else:
        main(sys.argv)