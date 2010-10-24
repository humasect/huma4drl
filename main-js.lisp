(in-package :gamelike)

(defmacro main-js-query ()
  `(progn
     (var *tile-width* 24)
     (var *tile-height* 30)
     (var *map-width* 32)
     (var *map-height* 24)

     (defun for-each-tile (fun)
       (loop for i from 0 to *map-width*
          do (loop for j from 0 to *map-height*
                do (fun i j))))

     (defun clear-map () (chain ($ "#view") (html "")))
     (defun tile-id (x y) (concatenate 'string "tile_" x "_" y))

     (defun set-tile (x y type)
       (let ((c ($ (tile-id x y)))
             (class (cond ((= type "#") "wall"))))
         (chain c (html type) (add-class class))))

     (defun create-map ()
       (for-each-tile
        (lambda (x y)
          (let ((c ($"<div/>"))
                (left (+ (* x *tile-width*) 64))
                (top (+ (* y *tile-height*) 64)))
            (chain c
                   (attr "id" (tile-id x y))
                   (add-class "tile")
                   (css (create :left left
                                :top top
                                :background-color "green"))
                   (html "#"))
            (chain ($ "#view") (append c))))))

     (chain ($ document) (ready create-map))))

(defmacro main-js ()
  `(progn
     (var *tile-size* (size-make ,*tile-width* ,*tile-height*))
     (var *screen-size* (size-make ,*scr-width* ,*scr-height*))
     (var *ctx* null)
     (var *world* null)

     (var *tile-width* ,*tile-width*)
     (var *tile-height* ,*tile-height*)
     (var *scr-width* ,*scr-width*)
     (var *scr-height* ,*scr-height*)

     (defun clog (msg &rest args)
       ((@ console log) (concatenate 'string msg args)))

     ;; (defun fill-tile (style x y)
     ;;   (let ((x)))
     ;;   ((@ *ctx* fillRect)))

     (defun mod-x (x) (* x *tile-width*))
     (defun mod-y (y) (* y *tile-height*))

     (defun fill-style (style)
       (setf (@ *ctx* fill-style) style))

     (defun fill-rect (r)
       (let ((x (@ r origin x))
             (y (@ r origin y))
             (w (@ r size width))
             (h (@ r size height)))
         ((@ *ctx* fill-rect) (mod-x x) (mod-y y) (mod-x w) (mod-y h))))

     (defun clear ()
       (fill-style "rgb(0,0,0)")
       (fill-rect (rect-make 0 0 *scr-width* *scr-height*)))

     (defun redraw ()
       (clear)
       (layer-render *world*))

     (defun start-game ()
       (setf *ctx* (chain (@ ($ "#canvas") 0) (get-context "2d")))
       (setf *world* (*layer "world" 0 0 *scr-width* *scr-height*))
       (layer-add-sublayer *world* (*layer "test" 100 100 100 100))
       (clog *world*)
       (redraw))

     (defun game-turn (angle)
       (clog "take a turn, angle: " angle)
       (redraw))

     (chain ($ document) (ready start-game))
     (setf (@ document onkeydown)
           (lambda (e)
             (let* ((angle-map (create
                                "d" 270
                                "b" 180
                                "f" 90
                                "h" 0

                                "g" 315
                                "i" 45
                                "c" 135
                                "a" 225))
                    (s ((@ *string from-char-code)
                        (or (@ e which) (@ e key-code))))
                    (a (getprop angle-map s)))
               (if (= undefined a)
                   (clog "unknown key: " s)
                   (game-turn a)))))
     ))

(defun output-main ()
  (output-js "main" '(main-js)))
