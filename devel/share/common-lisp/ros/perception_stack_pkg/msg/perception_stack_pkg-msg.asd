
(cl:in-package :asdf)

(defsystem "perception_stack_pkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "BoundingBox" :depends-on ("_package_BoundingBox"))
    (:file "_package_BoundingBox" :depends-on ("_package"))
    (:file "DetectionList" :depends-on ("_package_DetectionList"))
    (:file "_package_DetectionList" :depends-on ("_package"))
    (:file "HumanReadableObject" :depends-on ("_package_HumanReadableObject"))
    (:file "_package_HumanReadableObject" :depends-on ("_package"))
    (:file "OpticalFlow" :depends-on ("_package_OpticalFlow"))
    (:file "_package_OpticalFlow" :depends-on ("_package"))
  ))