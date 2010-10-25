(in-package :gamelike)

(defpsmacro for-each-actor (f)
  `(for-each (@ *world* actors) ,f))

(defmacro main-js ()
  `(progn
     (var *tile-width* ,*tile-width*)
     (var *tile-height* ,*tile-height*)
     (var *screen-width* ,*screen-width*)
     (var *screen-height* ,*screen-height*)

     (var *ctx* null)
     (var *screen* null)
     (var *world* null)

     (defun clear ()
       (cg-fill-style "rgb(0,0,0)")
       (cg-fill-rect (@ *screen* bounds)))

     (defun redraw ()
       (clear)
       (layer-render *screen*)
       (for-each-actor actor-render))

     (defun start-game ()
       (setf *ctx* (chain (@ ($ "#canvas") 0) (get-context "2d")))

       (cg-font 32 "helvetica")
       ;; set up layers
       ;;(setf *screen* (*layer "world"))
       ;;(set-bounds *screen* 
       (setf *screen*
             (new-layer :name "World"
                        :bounds (rect-make 0 0
                                           ,*screen-width*
                                           ,*screen-height*)))

       (layer-add-sublayer *screen*
        (new-layer :name "test-left"
                   :fill-style "red"
                   :bounds (rect-make 5 10 5 5)))

       (layer-add-sublayer *screen*
        (new-layer :name "test-right"
                   :fill-style "green"
                   :bounds (rect-make 20 10 5 5)))
       
       (clog *screen*)

       ;; set up actors
       (var player (*actor "Player" "@" 2 2))
       (var monster (*actor "Monster" "M" 10 10))
       (setf *world* (create actors (array player monster)))
       (clog *world*)

       (redraw))

     (defun actor-named (name)
       (var found null)
       (for-each-actor (lambda (a)
                         (if (= (@ a name) name)
                             (setf found a)
                             )))
       found)

     (defun game-turn (angle)
       ;;(clogf "take a turn, angle: " angle)
       (actor-move (actor-named "Player") angle)
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
