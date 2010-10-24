(in-package :gamelike)

(defmacro actor-js ()
  `(progn

     (defun *actor (name char x y)
       (create name name
               pos (point-make x y)
               char char))

     (defun actor-render (a)
       (clog a)
       (with-slots (char pos) a
         (cg-fill-style "yellow")
         ((@ *ctx* fill-text) char (point-x pos) (point-y pos))))
     ))

(defun output-actor ()
  (output-js "actor" '(actor-js)))
