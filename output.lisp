(require :cl-who)
(require :hunchentoot)
(require :parenscript)

(defpackage "LGamelike"
  (:use :cl :cl-who :hunchentoot :parenscript))

(in-package "LGamelike")

(load "index-html")
(load "main-js")

(defun output-file (name fun)
  (let* ((fname (concat "./htdocs/" name))
         (stream (open fname :direction :output :if-exists :supersede)))
    (setf *parenscript-stream* nil)
    (funcall fun stream)
    (close stream)
    (format t "done writing ~s~%" fname)))

(defun output-all ()
  (output-index)
  (output-main))
