(in-package :gamelike)

;; layer
(defpsmacro new-layer (&key (name "")
                            (fill-style "blue")
                            (stroke-style "white")
                            (bounds (rect-make 0 0 1 1)))
  `(create name ,name
           superlayer null
           sublayers (array)
           bounds ,bounds
           fill-style ,fill-style
           stroke-style ,stroke-style))

  ;; `(progn
  ;;    (var layer (*layer ,name))
  ;;    (layer-add-sublayer ,parent layer)
  ;;    (setf (@ layer fill-style) ,fill-style)
  ;;    (set-bounds layer ,bounds)))

(defpsmacro set-bounds (l b)
  `(setf (@ ,l bounds) ,b))

;; graphics
(defpsmacro cg-fill-style (style)
  `(setf (@ *ctx* fill-style) ,style))

(defpsmacro cg-fill-rect (r)
  `((@ *ctx* fill-rect)
    (* (rect-x ,r) *tile-width*)
    (* (rect-y ,r) *tile-height*)
    (* (rect-width ,r) *tile-width*)
    (* (rect-height ,r) *tile-height*)))

(defpsmacro cg-stroke-style (style)
  `(setf (@ *ctx* stroke-style) ,style))

(defpsmacro cg-font (size name)
  `(setf (@ *ctx* font) (concatenate 'string ,size "px " ,name)))


(defmacro anim-js ()
  `(progn
     ;; (defun *layer (n)
     ;;   (create name n
     ;;           superlayer null
     ;;           sublayers (array)
     ;;           bounds (rect-make 0 0 1 1)
     ;;           fill-style "blue"
     ;;           stroke-style "white"))

     (defun layer-add-sublayer (l s)
       ;; does not check if layer is already present.
       ;;(clog s)
       ;;(append (@ l sublayers) (list s))
       ((chain (@ l sublayers) push) s)
       (setf (@ s parent) l)
       )

     (defun layer-render (l)
       (with-slots (fill-style stroke-style bounds sublayers) l
         (progn
           (setprop *ctx* fill-style fill-style)
           (setprop *ctx* stroke-style stroke-style)
           (cg-fill-rect bounds)
           (for-each sublayers layer-render))))
     
     ))

(defun output-anim ()
  (output-js "anim" '(anim-js)))
