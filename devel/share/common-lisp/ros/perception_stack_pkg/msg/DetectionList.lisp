; Auto-generated. Do not edit!


(cl:in-package perception_stack_pkg-msg)


;//! \htmlinclude DetectionList.msg.html

(cl:defclass <DetectionList> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (detections
    :reader detections
    :initarg :detections
    :type (cl:vector perception_stack_pkg-msg:BoundingBox)
   :initform (cl:make-array 0 :element-type 'perception_stack_pkg-msg:BoundingBox :initial-element (cl:make-instance 'perception_stack_pkg-msg:BoundingBox))))
)

(cl:defclass DetectionList (<DetectionList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectionList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectionList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name perception_stack_pkg-msg:<DetectionList> is deprecated: use perception_stack_pkg-msg:DetectionList instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DetectionList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_stack_pkg-msg:header-val is deprecated.  Use perception_stack_pkg-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'detections-val :lambda-list '(m))
(cl:defmethod detections-val ((m <DetectionList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_stack_pkg-msg:detections-val is deprecated.  Use perception_stack_pkg-msg:detections instead.")
  (detections m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectionList>) ostream)
  "Serializes a message object of type '<DetectionList>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'detections))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'detections))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectionList>) istream)
  "Deserializes a message object of type '<DetectionList>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detections) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detections)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'perception_stack_pkg-msg:BoundingBox))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectionList>)))
  "Returns string type for a message object of type '<DetectionList>"
  "perception_stack_pkg/DetectionList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectionList)))
  "Returns string type for a message object of type 'DetectionList"
  "perception_stack_pkg/DetectionList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectionList>)))
  "Returns md5sum for a message object of type '<DetectionList>"
  "0c20dfffbd42980d9aac4e331ce27fd6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectionList)))
  "Returns md5sum for a message object of type 'DetectionList"
  "0c20dfffbd42980d9aac4e331ce27fd6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectionList>)))
  "Returns full string definition for message of type '<DetectionList>"
  (cl:format cl:nil "Header header~%BoundingBox[] detections~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: perception_stack_pkg/BoundingBox~%int32 x1~%int32 y1~%int32 x2~%int32 y2~%float32 confidence~%string class_name~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectionList)))
  "Returns full string definition for message of type 'DetectionList"
  (cl:format cl:nil "Header header~%BoundingBox[] detections~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: perception_stack_pkg/BoundingBox~%int32 x1~%int32 y1~%int32 x2~%int32 y2~%float32 confidence~%string class_name~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectionList>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detections) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectionList>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectionList
    (cl:cons ':header (header msg))
    (cl:cons ':detections (detections msg))
))
