(require :cl-who)
(require :hunchentoot)
(require :parenscript)

(defpackage :gamelike
  (:documentation "humasect 4-day roguelike")
  (:nicknames :gl)
  (:use :cl :cl-who :parenscript ; :hunchentoot
        )
  (:export *scr-width*))

(in-package :gamelike)

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
