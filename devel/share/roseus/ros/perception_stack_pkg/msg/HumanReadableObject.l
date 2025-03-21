;; Auto-generated. Do not edit!


(when (boundp 'perception_stack_pkg::HumanReadableObject)
  (if (not (find-package "PERCEPTION_STACK_PKG"))
    (make-package "PERCEPTION_STACK_PKG"))
  (shadow 'HumanReadableObject (find-package "PERCEPTION_STACK_PKG")))
(unless (find-package "PERCEPTION_STACK_PKG::HUMANREADABLEOBJECT")
  (make-package "PERCEPTION_STACK_PKG::HUMANREADABLEOBJECT"))

(in-package "ROS")
;;//! \htmlinclude HumanReadableObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass perception_stack_pkg::HumanReadableObject
  :super ros::object
  :slots (_class_name _speed _direction _position ))

(defmethod perception_stack_pkg::HumanReadableObject
  (:init
   (&key
    ((:class_name __class_name) "")
    ((:speed __speed) 0.0)
    ((:direction __direction) "")
    ((:position __position) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _class_name (string __class_name))
   (setq _speed (float __speed))
   (setq _direction (string __direction))
   (setq _position __position)
   self)
  (:class_name
   (&optional __class_name)
   (if __class_name (setq _class_name __class_name)) _class_name)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:direction
   (&optional __direction)
   (if __direction (setq _direction __direction)) _direction)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:serialization-length
   ()
   (+
    ;; string _class_name
    4 (length _class_name)
    ;; float32 _speed
    4
    ;; string _direction
    4 (length _direction)
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _class_name
       (write-long (length _class_name) s) (princ _class_name s)
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _direction
       (write-long (length _direction) s) (princ _direction s)
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _class_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _class_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _direction
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _direction (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;;
   self)
  )

(setf (get perception_stack_pkg::HumanReadableObject :md5sum-) "a9f70d272b495eeb16fc86a8a12ccddd")
(setf (get perception_stack_pkg::HumanReadableObject :datatype-) "perception_stack_pkg/HumanReadableObject")
(setf (get perception_stack_pkg::HumanReadableObject :definition-)
      "string class_name
float32 speed
string direction
geometry_msgs/Point position

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :perception_stack_pkg/HumanReadableObject "a9f70d272b495eeb16fc86a8a12ccddd")


