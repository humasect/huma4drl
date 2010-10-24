(in-package :gamelike)


(defpsmacro deflayer (&key (name "")
                           (sublayers nil)
                           (fill-style "blue")
                           (stroke-style "white")
                           (bounds nil))
  `(create superlayer null
           name (if (,name) ,name null)
           sublayers (if (,sublayers) ,sublayers null)
           bounds (if (,bounds) ,bounds (rect-make 0 0 0 0))
           fill-style ,fill-style
           stroke-style ,stroke-style))

(defpsmacro cg-fill-style (style)
  `(setf (@ *ctx* fill-style) ,style))

(defpsmacro cg-stroke-style (style)
  `(setf (@ *ctx* stroke-style) ,style))

(defpsmacro cg-font (size name)
  `(setf (@ *ctx* font) (concatenate 'string ,size "px " ,name)))

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
           (setprop *ctx* fill-style fill-style)
           (setprop *ctx* stroke-style stroke-style)
           (fill-rect bounds)
           (for-in (s sublayers) (layer-render s)))))
     
     ))

(defun output-anim ()
  (output-js "anim" '(anim-js)))
