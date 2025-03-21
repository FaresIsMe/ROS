#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np
import torch
from torchvision import transforms
from perception_stack_pkg.msg import BoundingBox, DetectionList

# The probles are all from hereeeeeeeeeeeee
#الدرجة راحت في السكريبت ده
from torchvision.models.segmentation import DeepLabV3_ResNet50_Weights
model = torch.hub.load('pytorch/vision:v0.10.0', 'deeplabv3_resnet50', weights=DeepLabV3_ResNet50_Weights.DEFAULT)
model.eval()

bridge = CvBridge()
frame_id = 0

# This was acually helpfull
preprocess = transforms.Compose([
    transforms.ToPILImage(),
    transforms.Resize((256, 256)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# HORSE?????? why??? t
CLASS_NAMES = [
    "background", "aeroplane", "bicycle", "bird", "boat", "bottle", "bus", "car", "cat",
    "chair", "cow", "dining table", "dog", "horse", "motorbike", "person", "potted plant",
    "sheep", "sofa", "train", "tv/monitor"
]


def extract_detections(segmentation_map):
    detections = []
    unique_classes = np.unique(segmentation_map)

    for class_id in unique_classes:
        if class_id == 0:
            continue
        mask = (segmentation_map == class_id).astype(np.uint8)
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)
            detection = BoundingBox()
            detection.x1 = x
            detection.y1 = y
            detection.x2 = x + w
            detection.y2 = y + h
            detection.width = w
            detection.height = h
            detection.confidence = 1.0
            detection.class_name = CLASS_NAMES[class_id]
            detections.append(detection)
    return detections

"""AI helped me like I was a damn toddler"""
# Process incoming images and publish results
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

        if output_resized.max() > 0:
            norm_map = ((output_resized / output_resized.max()) * 255).astype(np.uint8)
        else:
            norm_map = np.zeros_like(output_resized, dtype=np.uint8)

        segmented_frame = cv2.applyColorMap(norm_map, cv2.COLORMAP_JET)
        blended_output = cv2.addWeighted(cv_image, 0.7, segmented_frame, 0.3, 0)

        blended_msg = bridge.cv2_to_imgmsg(blended_output, encoding="rgb8")
        blended_pub.publish(blended_msg)

        detections = extract_detections(output_resized)

        # Funny enough, I know how to publish now هقهقهقهقهق
        det_list_msg = DetectionList()
        det_list_msg.header.stamp = rospy.Time.now()
        det_list_msg.frame_id = frame_id
        det_list_msg.detections = detections
        detections_pub.publish(det_list_msg)

        rospy.loginfo(f"Frame ID: {frame_id}")
        for detection in detections:
            rospy.loginfo(f"Class: {detection.class_name}, Confidence: {detection.confidence}")

        cv2.imshow("Blended Segmentation", blended_output)
        cv2.waitKey(1)

    except Exception as e:
        rospy.logerr(f"Error processing frame {frame_id}: {e}")

    rospy.spin()


#looking good today I am هقهقهقهقهق
if __name__ == "__main__":
    global blended_pub, detections_pub
    rospy.init_node('segmentation_and_detection_node')
    blended_pub = rospy.Publisher("/blended_frame", Image, queue_size=10)
    detections_pub = rospy.Publisher("/detections", DetectionList, queue_size=10)
    rospy.Subscriber("/camera_stream", Image, image_callback)
#for some reasom IDC anymore
#nobody is helping meeeeeeeeeeeeeeeee
#the call me the 1 for 5 team guy 
