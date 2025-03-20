;; Auto-generated. Do not edit!


(when (boundp 'client_server::mult)
  (if (not (find-package "CLIENT_SERVER"))
    (make-package "CLIENT_SERVER"))
  (shadow 'mult (find-package "CLIENT_SERVER")))
(unless (find-package "CLIENT_SERVER::MULT")
  (make-package "CLIENT_SERVER::MULT"))
(unless (find-package "CLIENT_SERVER::MULTREQUEST")
  (make-package "CLIENT_SERVER::MULTREQUEST"))
(unless (find-package "CLIENT_SERVER::MULTRESPONSE")
  (make-package "CLIENT_SERVER::MULTRESPONSE"))

(in-package "ROS")





(defclass client_server::multRequest
  :super ros::object
  :slots (_a _b ))

(defmethod client_server::multRequest
  (:init
   (&key
    ((:a __a) 0)
    ((:b __b) 0)
    )
   (send-super :init)
   (setq _a (round __a))
   (setq _b (round __b))
   self)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:serialization-length
   ()
   (+
    ;; int32 _a
    4
    ;; int32 _b
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _a
       (write-long _a s)
     ;; int32 _b
       (write-long _b s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _a
     (setq _a (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _b
     (setq _b (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass client_server::multResponse
  :super ros::object
  :slots (_result ))

(defmethod client_server::multResponse
  (:init
   (&key
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _result (round __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; int32 _result
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _result
       (write-long _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass client_server::mult
  :super ros::object
  :slots ())

(setf (get client_server::mult :md5sum-) "a7d7d7065d45755acef7d4dcf908162a")
(setf (get client_server::mult :datatype-) "client_server/mult")
(setf (get client_server::mult :request) client_server::multRequest)
(setf (get client_server::mult :response) client_server::multResponse)

(defmethod client_server::multRequest
  (:response () (instance client_server::multResponse :init)))

(setf (get client_server::multRequest :md5sum-) "a7d7d7065d45755acef7d4dcf908162a")
(setf (get client_server::multRequest :datatype-) "client_server/multRequest")
(setf (get client_server::multRequest :definition-)
      "int32 a
int32 b
---
int32 result

")

(setf (get client_server::multResponse :md5sum-) "a7d7d7065d45755acef7d4dcf908162a")
(setf (get client_server::multResponse :datatype-) "client_server/multResponse")
(setf (get client_server::multResponse :definition-)
      "int32 a
int32 b
---
int32 result

")



(provide :client_server/mult "a7d7d7065d45755acef7d4dcf908162a")


