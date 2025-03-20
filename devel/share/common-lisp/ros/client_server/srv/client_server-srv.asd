
(cl:in-package :asdf)

(defsystem "client_server-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "mult" :depends-on ("_package_mult"))
    (:file "_package_mult" :depends-on ("_package"))
  ))