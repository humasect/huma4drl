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

(defpsmacro for-each (x f)
  `(let ((__array ,x))
     (for-in (i __array) (,f (getprop __array i)))))

(defpsmacro clog (fmt)
  `((@ console log) ,fmt))

(defpsmacro clogf (fmt &rest args)
  `((@ console log) (concatenate 'string ,fmt ,@args)))

(defmacro main-js ()
  `(progn
     (var *tile-size* (size-make ,*tile-width* ,*tile-height*))
     (var *screen-size* (size-make ,*scr-width* ,*scr-height*))
     (var *ctx* null)
     (var *screen* null)
     (var *world* null)

     (var *tile-width* ,*tile-width*)
     (var *tile-height* ,*tile-height*)
     (var *scr-width* ,*scr-width*)
     (var *scr-height* ,*scr-height*)

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
       (layer-render *screen*)
       (for-each (@ *world* actors) actor-render))

     (defun start-game ()
       (setf *ctx* (chain (@ ($ "#canvas") 0) (get-context "2d")))
       (setf *screen* (*layer "world" 0 0 *scr-width* *scr-height*))
       (layer-add-sublayer *screen* (*layer "test" 10 10 10 10))
       ;;(deflayer :name "aoeuaoeu")
       (clog *screen*)

       (var player (*actor "Player" "@" 32 32))
       (var monster (*actor "Monster" "M" 100 80))
       (setf *world* (create actors (array player monster)))
       (clog *world*)

       (redraw))

     (defun game-turn (angle)
       (clogf "take a turn, angle: " angle)
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
                   (clogf "unknown key: " s)
                   (game-turn a)))))
     ))

(defun output-main ()
  (output-js "main" '(main-js)))
