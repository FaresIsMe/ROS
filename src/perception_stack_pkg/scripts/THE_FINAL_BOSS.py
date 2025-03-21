#!/usr/bin/env python3

import rospy
from perception_stack_pkg.msg import DetectionList, BoundingBox, OpticalFlow, HumanReadableObject
from geometry_msgs.msg import Vector3, Point
from message_filters import Subscriber, ApproximateTimeSynchronizer

def direction_to_words(vector):
    """Convert a motion vector into a human-readable direction."""
    if abs(vector.x) > abs(vector.y):
        if vector.x > 0:
            return "right"
        else:
            return "left"
    elif abs(vector.y) > abs(vector.x):
        if vector.y > 0:
            return "forward"
        else:
            return "backward"
    else:
        return "stationary"

def callback(detection_msg, optical_flow_msg):
    """Callback to process synchronized DetectionList and OpticalFlow messages."""
    processed_objects = DetectionList()
    processed_objects.header = detection_msg.header
    human_readable_objects = []

    for detection in detection_msg.detections:
        if detection_msg.header.frame_id == optical_flow_msg.header.frame_id:
            speed, direction_vector = estimate_speed_and_direction(detection, optical_flow_msg.vector)
            direction_words = direction_to_words(direction_vector)

            detection.x = (detection.x1 + detection.x2) // 2  # Center x
            detection.y = (detection.y1 + detection.y2) // 2  # Center y
            detection.width = detection.x2 - detection.x1
            detection.height = detection.y2 - detection.y1
            detection.speed = speed
            detection.direction = direction_vector

            human_object = HumanReadableObject()
            human_object.class_name = detection.class_name
            human_object.speed = speed
            human_object.direction = direction_words
            human_object.position = Point(detection.x, detection.y, 0)

            rospy.loginfo(f"Object: {human_object.class_name}, Speed: {human_object.speed:.2f} m/s, Direction: {human_object.direction}, Position: ({human_object.position.x}, {human_object.position.y})")
            human_readable_objects.append(human_object)

        else:
            rospy.logwarn(f"Frame ID mismatch: Detection Frame ID = {detection_msg.header.frame_id}, Optical Flow Frame ID = {optical_flow_msg.header.frame_id}")

        processed_objects.detections.append(detection)

    processed_pub.publish(processed_objects)

    for human_object in human_readable_objects:
        human_readable_pub.publish(human_object)

def estimate_speed_and_direction(detection, flow_data):
    """Estimate speed and direction of an object based on optical flow."""
    if flow_data:
        speed = (flow_data.x**2 + flow_data.y**2)**0.5
        direction = flow_data
    else:
        speed = 0.0
        direction = Vector3(0, 0, 0)  # No motion detected
    return speed, direction


if __name__ == "__main__":
    global processed_pub, human_readable_pub

    rospy.init_node('final_processor_node', anonymous=True)
    detection_sub = Subscriber("/2d_object_list", DetectionList)
    optical_flow_sub = Subscriber("/optical_flow", OpticalFlow)
    ats = ApproximateTimeSynchronizer([detection_sub, optical_flow_sub], queue_size=10, slop=0.1)
    ats.registerCallback(callback)
    processed_pub = rospy.Publisher("/final_object_list", DetectionList, queue_size=10)
    human_readable_pub = rospy.Publisher("/human_readable_objects", HumanReadableObject, queue_size=10)
    rospy.loginfo("Final Processor Node Initialized with synchronized topics.")
    rospy.spin()



#END ME NOW I CAN'T DO THIS ANYMORE