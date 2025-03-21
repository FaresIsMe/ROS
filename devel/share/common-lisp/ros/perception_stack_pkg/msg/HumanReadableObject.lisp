; Auto-generated. Do not edit!


(cl:in-package perception_stack_pkg-msg)


;//! \htmlinclude HumanReadableObject.msg.html

(cl:defclass <HumanReadableObject> (roslisp-msg-protocol:ros-message)
  ((class_name
    :reader class_name
    :initarg :class_name
    :type cl:string
    :initform "")
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (direction
    :reader direction
    :initarg :direction
    :type cl:string
    :initform "")
   (position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass HumanReadableObject (<HumanReadableObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HumanReadableObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HumanReadableObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name perception_stack_pkg-msg:<HumanReadableObject> is deprecated: use perception_stack_pkg-msg:HumanReadableObject instead.")))

(cl:ensure-generic-function 'class_name-val :lambda-list '(m))
(cl:defmethod class_name-val ((m <HumanReadableObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_stack_pkg-msg:class_name-val is deprecated.  Use perception_stack_pkg-msg:class_name instead.")
  (class_name m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <HumanReadableObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_stack_pkg-msg:speed-val is deprecated.  Use perception_stack_pkg-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'direction-val :lambda-list '(m))
(cl:defmethod direction-val ((m <HumanReadableObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_stack_pkg-msg:direction-val is deprecated.  Use perception_stack_pkg-msg:direction instead.")
  (direction m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <HumanReadableObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_stack_pkg-msg:position-val is deprecated.  Use perception_stack_pkg-msg:position instead.")
  (position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HumanReadableObject>) ostream)
  "Serializes a message object of type '<HumanReadableObject>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'class_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'class_name))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'direction))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'direction))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HumanReadableObject>) istream)
  "Deserializes a message object of type '<HumanReadableObject>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'class_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'class_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'direction) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'direction) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HumanReadableObject>)))
  "Returns string type for a message object of type '<HumanReadableObject>"
  "perception_stack_pkg/HumanReadableObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HumanReadableObject)))
  "Returns string type for a message object of type 'HumanReadableObject"
  "perception_stack_pkg/HumanReadableObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HumanReadableObject>)))
  "Returns md5sum for a message object of type '<HumanReadableObject>"
  "a9f70d272b495eeb16fc86a8a12ccddd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HumanReadableObject)))
  "Returns md5sum for a message object of type 'HumanReadableObject"
  "a9f70d272b495eeb16fc86a8a12ccddd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HumanReadableObject>)))
  "Returns full string definition for message of type '<HumanReadableObject>"
  (cl:format cl:nil "string class_name~%float32 speed~%string direction~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HumanReadableObject)))
  "Returns full string definition for message of type 'HumanReadableObject"
  (cl:format cl:nil "string class_name~%float32 speed~%string direction~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HumanReadableObject>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'class_name))
     4
     4 (cl:length (cl:slot-value msg 'direction))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HumanReadableObject>))
  "Converts a ROS message object to a list"
  (cl:list 'HumanReadableObject
    (cl:cons ':class_name (class_name msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':direction (direction msg))
    (cl:cons ':position (position msg))
))
