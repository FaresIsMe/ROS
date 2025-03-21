#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np
from geometry_msgs.msg import Vector3
from perception_stack_pkg.msg import OpticalFlow


# realizing how old I'm and rethinking my life choices in this damn electrical shit

bridge = CvBridge()
prev_gray = None
frame_id = 0

def process_optical_flow(msg):
    global prev_gray, frame_id
    try:

        #converting the best part that doesn't go wrong I love it
        current_frame = bridge.imgmsg_to_cv2(msg, "bgr8")
        gray_frame = cv2.cvtColor(current_frame, cv2.COLOR_BGR2GRAY)
        header = msg.header
        frame_id = header.frame_id

        if prev_gray is None:
            prev_gray = gray_frame
            return
        #this part is straight not me I just founded somewhere by the ai LOL
        flow = cv2.calcOpticalFlowFarneback(prev_gray, gray_frame, None, 0.5, 3, 15, 3, 5, 1.2, 0)
        h, w = gray_frame.shape
        step = 16
        y, x = np.mgrid[step//2:h:step, step//2:w:step].reshape(2, -1).astype(int)
        dx, dy = flow[y, x].T
        for (x_i, y_i, dx_i, dy_i) in zip(x, y, dx, dy):
            end_point = (int(x_i + dx_i), int(y_i + dy_i))
            cv2.arrowedLine(current_frame, (x_i, y_i), end_point, (0, 255, 0), 1, tipLength=0.2)

        #publishig the shit
        average_dx = np.mean(flow[..., 0])
        average_dy = np.mean(flow[..., 1])

        optical_flow_msg = OpticalFlow()
        optical_flow_msg.header = header
        optical_flow_msg.header.stamp = rospy.Time.now()
        optical_flow_msg.header.frame_id = str(frame_id)
        optical_flow_msg.vector = Vector3(average_dx, average_dy, 0)

        flow_pub.publish(optical_flow_msg)

        cv2.imshow("Optical Flow - Motion Vectors", current_frame)
        cv2.waitKey(1)

        rospy.loginfo(f"Published Flow - Motion Vectors: {frame_id}")

        prev_gray = gray_frame

    except Exception as e:
        rospy.logerr(f"Error processing optical flow: {e}")



"""hello everyone"""

if __name__ == "__main__":
    rospy.init_node('optical_flow_node', anonymous=True)
    rospy.Subscriber("/camera_stream", Image, process_optical_flow)
    flow_pub = rospy.Publisher("/optical_flow", OpticalFlow, queue_size=10)#I had to make another msg file for this shit
    rospy.loginfo("Optical flow node is subscribed to /camera_stream topic and publishing to /optical_flow topic")
    rospy.spin()
    cv2.destroyAllWindows()

"""Bye everyone
the call me the TEAM carrier
my shoulders hurt
Fares is the GOAT"""
