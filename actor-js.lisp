(in-package :gamelike)

(defvar *act-move-amt* 1)    ;; 32

(defmacro actor-js ()
  `(progn

     (defun *actor (name char x y)
       (create name name
               pos (point-make x y)
               char char))

     (defun actor-render (a)
       (with-slots (char pos) a
         (cg-fill-style "yellow")
         ((@ *ctx* fill-text) char (point-scr-x pos) (point-scr-y pos))))

     (defun actor-move (a angle)
       (let* ((by (point-rotate (point-make 0 -1) (deg-to-rad angle)))
              (to (point-add (@ a pos) (point-snap by 1))))
         (setf (@ a pos) (keep-point-in-rect to (@ *screen* bounds)))
         ;;(clogf "position = " to)
         ))

     ))

(defun output-actor ()
  (output-js "actor" '(actor-js)))
