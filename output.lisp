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

;;(load "gamelike-html")
;;(load "main-js")

(defun output-js (name body)
  (output-file (concatenate 'string name ".js")
               (lambda (stream)
                 (setf *parenscript-stream* stream)
                 (parenscript:ps* (macroexpand-1 body)))))

;; (defmacro define-js (name &rest body)
;;   `(output-js ,@name ,@body))

(defun output-all ()
  (output-index)
  (output-main)
  (output-geom)
  (output-anim)
  (output-actor)
  (output-map))


;; some utility stuff

(defpsmacro clog (fmt)
  `((@ console log) ,fmt))

(defpsmacro clogf (fmt &rest args)
  `((@ console log) (concatenate 'string ,fmt ,@args)))

(defpsmacro defproto (class name &body body)
  `(setf (@ ,class prototype ,name) ,@body))

(defpsmacro setprop (object key value)
  `(setf (@ ,object ,key) ,value))

(defpsmacro setthis (key value)
  `(setf (@ this ,key) ,value))

(defpsmacro for-each (x f)
  `(for-in (i ,x) (,f (getprop ,x i))))

