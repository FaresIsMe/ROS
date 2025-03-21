#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2


def camera_stream():
    rospy.init_node('camera_streamer_node', anonymous=True)
    pub = rospy.Publisher("/camera_stream", Image, queue_size=10)
    bridge = CvBridge()

    capture = cv2.VideoCapture("/home/fares/Downloads/Dashcam Catches T-Bone Crash __ ViralHog.mp4")

    if not capture.isOpened():
        rospy.logerr("Capture failed to open")

    frame_number = 0
    rate = rospy.Rate(5)  # Hz

    while not rospy.is_shutdown():
        ret, frame = capture.read()

        if not ret:
            rospy.loginfo("video is finished")
            break
        
        image_message = bridge.cv2_to_imgmsg(frame, encoding="bgr8")
        image_message.header.stamp = rospy.Time.now()
        image_message.header.frame_id = str(frame_number)
        frame_number += 1

        pub.publish(image_message)
        rospy.loginfo(f"The frame {frame_number} published")
        rate.sleep()



if __name__ == '__main__':
    try:
        camera_stream()
    except rospy.ROSInterruptException:
        pass