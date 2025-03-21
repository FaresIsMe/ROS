;; Auto-generated. Do not edit!


(when (boundp 'perception_stack_pkg::DetectionList)
  (if (not (find-package "PERCEPTION_STACK_PKG"))
    (make-package "PERCEPTION_STACK_PKG"))
  (shadow 'DetectionList (find-package "PERCEPTION_STACK_PKG")))
(unless (find-package "PERCEPTION_STACK_PKG::DETECTIONLIST")
  (make-package "PERCEPTION_STACK_PKG::DETECTIONLIST"))

(in-package "ROS")
;;//! \htmlinclude DetectionList.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass perception_stack_pkg::DetectionList
  :super ros::object
  :slots (_header _frame_id _detections ))

(defmethod perception_stack_pkg::DetectionList
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:frame_id __frame_id) 0)
    ((:detections __detections) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _frame_id (round __frame_id))
   (setq _detections __detections)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:frame_id
   (&optional __frame_id)
   (if __frame_id (setq _frame_id __frame_id)) _frame_id)
  (:detections
   (&rest __detections)
   (if (keywordp (car __detections))
       (send* _detections __detections)
     (progn
       (if __detections (setq _detections (car __detections)))
       _detections)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _frame_id
    4
    ;; perception_stack_pkg/BoundingBox[] _detections
    (apply #'+ (send-all _detections :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _frame_id
       (write-long _frame_id s)
     ;; perception_stack_pkg/BoundingBox[] _detections
     (write-long (length _detections) s)
     (dolist (elem _detections)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _frame_id
     (setq _frame_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; perception_stack_pkg/BoundingBox[] _detections
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _detections (let (r) (dotimes (i n) (push (instance perception_stack_pkg::BoundingBox :init) r)) r))
     (dolist (elem- _detections)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get perception_stack_pkg::DetectionList :md5sum-) "78ca9429b3b363536a5e96154f3d5dfd")
(setf (get perception_stack_pkg::DetectionList :datatype-) "perception_stack_pkg/DetectionList")
(setf (get perception_stack_pkg::DetectionList :definition-)
      "Header header
int32 frame_id
BoundingBox[] detections

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: perception_stack_pkg/BoundingBox
int32 x1
int32 y1
int32 x2
int32 y2
float32 confidence
string class_name
int32 class_id
int32 x
int32 y
int32 width
int32 height
float32 speed
geometry_msgs/Vector3 direction


================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :perception_stack_pkg/DetectionList "78ca9429b3b363536a5e96154f3d5dfd")


