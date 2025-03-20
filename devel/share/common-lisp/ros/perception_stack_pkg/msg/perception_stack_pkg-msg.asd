
(cl:in-package :asdf)

(defsystem "perception_stack_pkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "BoundingBox" :depends-on ("_package_BoundingBox"))
    (:file "_package_BoundingBox" :depends-on ("_package"))
    (:file "DetectionList" :depends-on ("_package_DetectionList"))
    (:file "_package_DetectionList" :depends-on ("_package"))
  ))