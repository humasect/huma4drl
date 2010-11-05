(in-package :huma4drl)

;(defvar *act-move-amt* 1)    ;; 32

(defpsmacro new-actor (name char x y)
  `(new-layer :name ,name
              :bounds (rect-make ,x ,y 1 1)
              :contents ,char
              :fill-style "yellow"))

(defun actor-js (stream)
  (ps-to-stream* stream
    `(progn

      (defun actor-move (a angle)
        (let* ((by (point-rotate (point-make 0 -1) (deg-to-rad angle)))
               (to (point-add (layer-origin a) (point-snap by 1))))
          ;(setprop a bounds (rect-make (.x up) (.y up) 1 1))
          (setf (layer-origin a) (keep-point-in-rect to (@ *screen* bounds)))
          ))

      )))


