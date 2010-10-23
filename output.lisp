(require :cl-who)
(require :hunchentoot)
(require :parenscript)

(defpackage "LGamelike"
  (:use :cl :cl-who :hunchentoot :parenscript))

(in-package "LGamelike")

(defun output-file (name fun)
  (let* ((fname (concatenate 'string "../huma4drl_gh-pages/" name))
         (stream (open fname :direction :output :if-exists :supersede)))
    (setf *parenscript-stream* nil)
    (funcall fun stream)
    (close stream)
    (format t "done writing ~s~%" fname)))

(load "gamelike-html")
(load "main-js")

(defun output-all ()
  (output-index)
  (output-main))