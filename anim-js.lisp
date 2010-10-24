(in-package :gamelike)

(defpsmacro defproto (class name &body body)
  `(setf (@ ,class prototype ,name) ,@body))

(defpsmacro setprop (object key value)
  `(setf (@ ,object ,key) ,value))

(defpsmacro setthis (key value)
  `(setf (@ this ,key) ,value))

;; (defpsmacro modprop (object key setter)
;;   `(let ((value (funcall setter (@ object key))))
;;      (setf (@ ,object ,key) ,value)))

(defmacro anim-js ()
  `(progn
     (defun *layer (n x y w h)
       (create name n
               superlayer null
               sublayers (array)
               bounds (rect-make x y w h)
               fill-style "blue"
               stroke-style "white"))

     (defun layer-add-sublayer (l s)
       ;; does not check if layer is already present.
       (append (@ l sublayers) (list s)))

     (defun layer-render (l)
       (with-slots (fill-style stroke-style bounds sublayers) l
         (progn
           (clog "aoeuaoeuaoeu" bounds)
           (setprop *ctx* fill-style fill-style)
           (setprop *ctx* stroke-style stroke-style)
           (fill-rect bounds)
           (for-in (s sublayers) (layer-render s)))))
     
     ))

(defun output-anim ()
  (output-js "anim" '(anim-js)))
