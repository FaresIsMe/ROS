;; Auto-generated. Do not edit!


(when (boundp 'perception_stack_pkg::OpticalFlow)
  (if (not (find-package "PERCEPTION_STACK_PKG"))
    (make-package "PERCEPTION_STACK_PKG"))
  (shadow 'OpticalFlow (find-package "PERCEPTION_STACK_PKG")))
(unless (find-package "PERCEPTION_STACK_PKG::OPTICALFLOW")
  (make-package "PERCEPTION_STACK_PKG::OPTICALFLOW"))

(in-package "ROS")
;;//! \htmlinclude OpticalFlow.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass perception_stack_pkg::OpticalFlow
  :super ros::object
  :slots (_header _vector ))

(defmethod perception_stack_pkg::OpticalFlow
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vector __vector) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _vector __vector)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vector
   (&rest __vector)
   (if (keywordp (car __vector))
       (send* _vector __vector)
     (progn
       (if __vector (setq _vector (car __vector)))
       _vector)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Vector3 _vector
    (send _vector :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Vector3 _vector
       (send _vector :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Vector3 _vector
     (send _vector :deserialize buf ptr-) (incf ptr- (send _vector :serialization-length))
   ;;
   self)
  )

(setf (get perception_stack_pkg::OpticalFlow :md5sum-) "7b324c7325e683bf02a9b14b01090ec7")
(setf (get perception_stack_pkg::OpticalFlow :datatype-) "perception_stack_pkg/OpticalFlow")
(setf (get perception_stack_pkg::OpticalFlow :definition-)
      "std_msgs/Header header
geometry_msgs/Vector3 vector

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



(provide :perception_stack_pkg/OpticalFlow "7b324c7325e683bf02a9b14b01090ec7")


