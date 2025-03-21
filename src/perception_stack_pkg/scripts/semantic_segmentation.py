#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np
import torch
from torchvision import transforms
from perception_stack_pkg.msg import BoundingBox, DetectionList

# Load the pre-trained DeepLabV3 model
model = torch.hub.load('pytorch/vision:v0.10.0', 'deeplabv3_resnet50', pretrained=True)
model.eval()

# Set up the ROS-to-OpenCV bridge
bridge = CvBridge()

# Initialize a frame counter
frame_id = 0

# Define preprocessing transformations for the model
preprocess = transforms.Compose([
    transforms.ToPILImage(),
    transforms.Resize((256, 256)),  # Resize for the model
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# Define a fixed colormap (21 classes based on DeepLabV3 training data)
COLORMAP = np.array([
    [0, 0, 0],        # Background (Black)
    [128, 0, 0],      # Aeroplane (Maroon)
    [0, 128, 0],      # Bicycle (Green)
    [128, 128, 0],    # Bird (Olive)
    [0, 0, 128],      # Boat (Navy Blue)
    [128, 0, 128],    # Bottle (Purple)
    [0, 128, 128],    # Bus (Teal)
    [128, 128, 128],  # Car (Gray)
    [64, 0, 0],       # Cat (Dark Red)
    [192, 0, 0],      # Chair (Bright Red)
    [64, 128, 0],     # Cow (Dark Olive)
    [192, 128, 0],    # Dining Table (Orange)
    [64, 0, 128],     # Dog (Dark Purple)
    [192, 0, 128],    # Horse (Pink)
    [64, 128, 128],   # Motorbike (Dark Teal)
    [192, 128, 128],  # Person (Light Pink)
    [0, 64, 0],       # Potted Plant (Dark Green)
    [128, 64, 0],     # Sheep (Brown)
    [0, 192, 0],      # Sofa (Bright Green)
    [128, 192, 0],    # Train (Lime)
    [0, 64, 128],     # TV/Monitor (Sky Blue)
], dtype=np.uint8)


def extract_bounding_boxes(segmentation_map):
    """Extract bounding boxes for detected objects."""
    bounding_boxes = []
    unique_classes = np.unique(segmentation_map)

    for class_id in unique_classes:
        if class_id == 0:  # Skip background class
            continue

        # Find contours for the given class
        mask = (segmentation_map == class_id).astype(np.uint8)
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)  # Bounding box coordinates
            bounding_boxes.append({
                "class_id": class_id,
                "x": x,
                "y": y,
                "width": w,
                "height": h
            })

    return bounding_boxes


def image_callback(msg):
    global frame_id

    try:
        frame_id += 1
        cv_image = bridge.imgmsg_to_cv2(msg, "bgr8")
        original_size = cv_image.shape[:2]

        input_tensor = preprocess(cv_image)
        input_batch = input_tensor.unsqueeze(0)

        with torch.no_grad():
            output = model(input_batch)['out'][0]
        output_predictions = output.argmax(0).byte().numpy()

        output_resized = cv2.resize(output_predictions, (original_size[1], original_size[0]), interpolation=cv2.INTER_NEAREST)

        segmented_frame = COLORMAP[output_resized]
        blended_output = cv2.addWeighted(cv_image, 0.7, segmented_frame, 0.3, 0)
        blended_msg = bridge.cv2_to_imgmsg(blended_output, encoding="rgb8")
        blended_pub.publish(blended_msg)

        # Extract bounding boxes from the segmentation map
        bounding_boxes = extract_bounding_boxes(output_resized)

        # Create a DetectionsList message
        detections_msg = DetectionList()
        detections_msg.header.stamp = rospy.Time.now()
        detections_msg.frame_id = frame_id

        for bbox in bounding_boxes:
            box_msg = BoundingBox()
            box_msg.class_id = bbox["class_id"]
            box_msg.x = bbox["x"]
            box_msg.y = bbox["y"]
            box_msg.width = bbox["width"]
            box_msg.height = bbox["height"]
            detections_msg.detections.append(box_msg)

        # Publish the detections message
        detections_pub.publish(detections_msg)

        # Display the blended output
        cv2.imshow("Blended Segmentation", blended_output)
        cv2.waitKey(1)

        rospy.loginfo(f"Frame ID: {frame_id} - Published detections for {len(bounding_boxes)} objects.")

    except Exception as e:
        rospy.logerr(f"Error in processing image (Frame ID: {frame_id}): {e}")


def main():
    global blended_pub, detections_pub

    rospy.init_node('blended_segmentation_node')

    blended_pub = rospy.Publisher("/blended_frame", Image, queue_size=10)
    detections_pub = rospy.Publisher("/blended_detections", DetectionList, queue_size=10)

    rospy.Subscriber("/camera_stream", Image, image_callback)
    rospy.loginfo("Blended Segmentation Node Initialized.")
    rospy.spin()


if __name__ == "__main__":
    main()
