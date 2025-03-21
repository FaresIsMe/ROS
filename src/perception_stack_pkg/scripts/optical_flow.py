#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np

# Initialize global variables
bridge = CvBridge()
prev_gray = None

def process_optical_flow(msg):
    global prev_gray
    try:

        current_frame = bridge.imgmsg_to_cv2(msg, "bgr8")
        gray_frame = cv2.cvtColor(current_frame, cv2.COLOR_BGR2GRAY)

        if prev_gray is None:
            prev_gray = gray_frame
            return
        
        flow = cv2.calcOpticalFlowFarneback(prev_gray, gray_frame, None, 0.5, 3, 15, 3, 5, 1.2, 0)
        h, w = gray_frame.shape
        step = 16
        y, x = np.mgrid[step//2:h:step, step//2:w:step].reshape(2, -1).astype(int)
        dx, dy = flow[y, x].T
        for (x_i, y_i, dx_i, dy_i) in zip(x, y, dx, dy):
            end_point = (int(x_i + dx_i), int(y_i + dy_i))
            cv2.arrowedLine(current_frame, (x_i, y_i), end_point, (0, 255, 0), 1, tipLength=0.2)

        cv2.imshow("Optical Flow - Motion Vectors", current_frame)
        cv2.waitKey(1)

        prev_gray = gray_frame

    except Exception as e:
        rospy.logerr(f"Error processing optical flow: {e}")




if __name__ == "__main__":
    rospy.init_node('optical_flow_node', anonymous=True)
    rospy.Subscriber("/camera_stream", Image, process_optical_flow)
    rospy.spin()
    cv2.destroyAllWindows()
