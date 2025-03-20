#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import sys
import torch
import numpy as np
import cv2

sys.path.append('/home/fares/Downloads/Depth-Anything-V2')
from depth_anything_v2.dpt import DepthAnythingV2

# Initialize CvBridge
bridge = CvBridge()

# Model configurations
model_configs = {
    'vits': {'encoder': 'vits', 'features': 64, 'out_channels': [48, 96, 192, 384]},
    'vitb': {'encoder': 'vitb', 'features': 128, 'out_channels': [96, 192, 384, 768]},
    'vitl': {'encoder': 'vitl', 'features': 256, 'out_channels': [256, 512, 1024, 1024]}
}

encoder = 'vits'

# Ensure compatibility with CPU or GPU
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# Initialize and load the model
model = DepthAnythingV2(**model_configs[encoder])
model.load_state_dict(torch.load(
    '/home/fares/Downloads/depth_anything_v2_metric_vkitti_vits.pth',
    map_location=device,
    weights_only=True
), strict=False)
model.to(device)
model.eval()


def normalize(depth_map):
    try:
        max_depth = np.max(depth_map)
        min_depth = np.min(depth_map)

        if max_depth - min_depth > 0:
            visualize_depth = 255 * (depth_map - min_depth) / (max_depth - min_depth)
        else:
            visualize_depth = np.zeros_like(depth_map)
            rospy.logerr("Depth map is empty or all elements are equal.")

        return np.clip(visualize_depth, 0, 255).astype(np.uint8)

    except Exception as e:
        rospy.logerr(f"Error normalizing depth: {e}")
        return None


depth_pub = None


def depth_estimation(image_msg):
    global bridge, depth_pub

    try:
        # Retrieve image message header
        image_msg_header = image_msg.header

        frame = bridge.imgmsg_to_cv2(image_msg, desired_encoding="bgr8")

        # Perform depth estimation
        with torch.no_grad():
            frame_tensor = torch.from_numpy(frame).float().permute(2, 0, 1).unsqueeze(0).to(device)
            depth_map = model.infer_image(frame_tensor).squeeze(0).cpu().numpy()

        # Normalize and visualize depth
        norm_depth_map = normalize(depth_map)
        depth_colored = cv2.applyColorMap(norm_depth_map, cv2.COLORMAP_JET)

        # Resize and combine RGB and depth visuals
        depth_resized = cv2.resize(depth_colored, (0, 0), fx=0.5, fy=0.5)
        frame_resized = cv2.resize(frame, (0, 0), fx=0.5, fy=0.5)
        combined = np.hstack((frame_resized, depth_resized))

        cv2.imshow("RGB Frame and Depth Estimation", combined)
        cv2.waitKey(1)

        # Publish depth map
        depth_msg = bridge.cv2_to_imgmsg(depth_map, encoding="32FC1")
        depth_msg.header = image_msg_header
        depth_pub.publish(depth_msg)

    except Exception as e:
        rospy.logerr(f"Error in depth estimation: {e}")


if __name__ == '__main__':
    try:
        topic_name = "/camera_stream"

        rospy.init_node('depth_estimation')

        # Subscriber and publisher initialization
        depth_sub = rospy.Subscriber(topic_name, Image, depth_estimation, queue_size=1)
        depth_pub = rospy.Publisher("/depth_map", Image, queue_size=1)
        rospy.loginfo(f"Depth estimation node is subscribed to {topic_name} topic and publishing to /depth_map node")
        rospy.spin()

    except rospy.ROSInterruptException:
        rospy.loginfo("Shutting down depth estimation node.")
        cv2.destroyAllWindows()
