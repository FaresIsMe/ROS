;; Auto-generated. Do not edit!


(when (boundp 'perception_stack_pkg::BoundingBox)
  (if (not (find-package "PERCEPTION_STACK_PKG"))
    (make-package "PERCEPTION_STACK_PKG"))
  (shadow 'BoundingBox (find-package "PERCEPTION_STACK_PKG")))
(unless (find-package "PERCEPTION_STACK_PKG::BOUNDINGBOX")
  (make-package "PERCEPTION_STACK_PKG::BOUNDINGBOX"))

(in-package "ROS")
;;//! \htmlinclude BoundingBox.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass perception_stack_pkg::BoundingBox
  :super ros::object
  :slots (_x1 _y1 _x2 _y2 _confidence _class_name _class_id _x _y _width _height _speed _direction ))

(defmethod perception_stack_pkg::BoundingBox
  (:init
   (&key
    ((:x1 __x1) 0)
    ((:y1 __y1) 0)
    ((:x2 __x2) 0)
    ((:y2 __y2) 0)
    ((:confidence __confidence) 0.0)
    ((:class_name __class_name) "")
    ((:class_id __class_id) 0)
    ((:x __x) 0)
    ((:y __y) 0)
    ((:width __width) 0)
    ((:height __height) 0)
    ((:speed __speed) 0.0)
    ((:direction __direction) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _x1 (round __x1))
   (setq _y1 (round __y1))
   (setq _x2 (round __x2))
   (setq _y2 (round __y2))
   (setq _confidence (float __confidence))
   (setq _class_name (string __class_name))
   (setq _class_id (round __class_id))
   (setq _x (round __x))
   (setq _y (round __y))
   (setq _width (round __width))
   (setq _height (round __height))
   (setq _speed (float __speed))
   (setq _direction __direction)
   self)
  (:x1
   (&optional __x1)
   (if __x1 (setq _x1 __x1)) _x1)
  (:y1
   (&optional __y1)
   (if __y1 (setq _y1 __y1)) _y1)
  (:x2
   (&optional __x2)
   (if __x2 (setq _x2 __x2)) _x2)
  (:y2
   (&optional __y2)
   (if __y2 (setq _y2 __y2)) _y2)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:class_name
   (&optional __class_name)
   (if __class_name (setq _class_name __class_name)) _class_name)
  (:class_id
   (&optional __class_id)
   (if __class_id (setq _class_id __class_id)) _class_id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:direction
   (&rest __direction)
   (if (keywordp (car __direction))
       (send* _direction __direction)
     (progn
       (if __direction (setq _direction (car __direction)))
       _direction)))
  (:serialization-length
   ()
   (+
    ;; int32 _x1
    4
    ;; int32 _y1
    4
    ;; int32 _x2
    4
    ;; int32 _y2
    4
    ;; float32 _confidence
    4
    ;; string _class_name
    4 (length _class_name)
    ;; int32 _class_id
    4
    ;; int32 _x
    4
    ;; int32 _y
    4
    ;; int32 _width
    4
    ;; int32 _height
    4
    ;; float32 _speed
    4
    ;; geometry_msgs/Vector3 _direction
    (send _direction :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _x1
       (write-long _x1 s)
     ;; int32 _y1
       (write-long _y1 s)
     ;; int32 _x2
       (write-long _x2 s)
     ;; int32 _y2
       (write-long _y2 s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _class_name
       (write-long (length _class_name) s) (princ _class_name s)
     ;; int32 _class_id
       (write-long _class_id s)
     ;; int32 _x
       (write-long _x s)
     ;; int32 _y
       (write-long _y s)
     ;; int32 _width
       (write-long _width s)
     ;; int32 _height
       (write-long _height s)
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Vector3 _direction
       (send _direction :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _x1
     (setq _x1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y1
     (setq _y1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _x2
     (setq _x2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y2
     (setq _y2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _class_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _class_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _class_id
     (setq _class_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _x
     (setq _x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y
     (setq _y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Vector3 _direction
     (send _direction :deserialize buf ptr-) (incf ptr- (send _direction :serialization-length))
   ;;
   self)
  )

(setf (get perception_stack_pkg::BoundingBox :md5sum-) "b3294fcf8c14633436ae2e0b4ba8ac4c")
(setf (get perception_stack_pkg::BoundingBox :datatype-) "perception_stack_pkg/BoundingBox")
(setf (get perception_stack_pkg::BoundingBox :definition-)
      "int32 x1
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



(provide :perception_stack_pkg/BoundingBox "b3294fcf8c14633436ae2e0b4ba8ac4c")


