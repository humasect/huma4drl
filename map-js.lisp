(in-package :gamelike)

(defmacro map-js ()
  `(progn
     ))

(defun output-map ()
  (output-js "map" '(map-js)))
