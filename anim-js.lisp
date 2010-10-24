(in-package :gamelike)

(defmacro apply-point (p f)
  `(,f (@ ,p x) (@ ,p y)))

(defmacro anim-js ()
  `(progn
     ;; (setf *layer (lambda (name)
     ;;                (setf (@ this name) name)
     ;;                this))
     ;; (setf (@ *layer prototype ) )

     

     (defun new-layer (n)
       (create name n
               superlayer null
               sublayers (array)
               origin (array 0 0)
               size (array 0 0)))
     ))

(defun output-anim ()
  (output-js "anim" '(anim-js)))
