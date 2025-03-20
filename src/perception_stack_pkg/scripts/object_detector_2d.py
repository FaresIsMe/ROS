#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
from ultralytics import YOLO
import cv2
from perception_stack_pkg.msg import BoundingBox, DetectionList


bridge = CvBridge()
model = YOLO("/home/fares/Desktop/catkin_ws/src/perception_stack_pkg/scripts/yolo11n.pt")


def object_detected(image_msg):
    global bridge

    try:
        # Get the image message header
        image_message_header = image_msg.header
        msg_stamp = image_message_header.stamp
        msg_frame_id = image_message_header.frame_id

        # Convert the image message to OpenCV image
        frame = bridge.imgmsg_to_cv2(image_msg, desired_encoding="bgr8")

        # Perform object detection
        result = model(frame)[0]
        rospy.loginfo(f"Image detected, frame {msg_frame_id} {frame.dtype}")


        det_list_msg = DetectionList()
        det_list_msg.header = image_message_header


        for box in result.boxes:
            x1, y1, x2, y2 = map(int, box.xyxy[0])  # Coordinates
            confidence = float(box.conf[0]) 
            class_id = int(box.cls[0])
            class_name = model.names[class_id]

            box = BoundingBox()
            box.x1 = x1
            box.y1 = y1
            box.x2 = x2
            box.y2 = y2
            box.confidence = confidence
            box.class_name = class_name
            det_list_msg.detections.append(box)
            
            # Draw rectangle and label on the frame
            cv2.rectangle(frame, (x1, y1), (x2, y2), (1, 2, 255), 2) #BGR
            cv2.putText(frame, f"{class_name} {confidence:.2f}", (x1, y1 - 20), 
                        cv2.FONT_HERSHEY_SIMPLEX, 0.9, (36, 200, 12), 1) #BGR
            
            pub.publish(det_list_msg)
            #rospy.loginfo(f"Object detected and published: {class_name}")
            


        # Show the image with detections
        cv2.imshow("Object Detection", frame)
        cv2.waitKey(1)


    except Exception as e:
        rospy.logerr(f"Error in object detection: {e}")
            

if __name__ == '__main__':
    try:
        topic_name = "/camera_stream"
        rospy.init_node('object_detector_2d')
        sub = rospy.Subscriber(f"{topic_name}", Image, object_detected)
        pub = rospy.Publisher("/2d_object_list", DetectionList, queue_size=1000)
        rospy.loginfo(f"object_detector_2d node is subscribed to /{topic_name} topic")
        rospy.spin()

    except rospy.ROSInterruptException:
        rospy.loginfo("Shutting down YOLO object detector node.")
        cv2.destroyAllWindows()

