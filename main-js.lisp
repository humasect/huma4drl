(in-package :gamelike)

(defun main-js (stream)
  (ps-to-stream* stream
    `(progn
       (var *pieces* nil)
       (var *actors* nil)
       
       (defun redraw ()
         (layer-render *screen*))

       (defun start-main ()
         ;; set up temp level pieces
         (setf *pieces* (new-layer :name "*pieces*" :contents 'empty))
         (layer-add-sublayer *screen* *pieces*)
         (layer-add-sublayers *pieces*
                              (list (new-layer
                                     :name "test-left"
                                     :fill-style "red"
                                     :bounds (rect-make 5 10 5 5))
                                    (new-layer
                                     :name "test-right"
                                     :fill-style "green"
                                     :bounds (rect-make 20 10 5 5))))
         
         ;; set up actors
         (setf *actors* (new-layer :name "*actors*" :contents 'empty))
         (layer-add-sublayer *screen* *actors*)
         (layer-add-sublayers *actors* (list (new-actor "Player" "@" 2 2)
                                             (new-actor "Monster" "M" 10 10)))

         (setprop *screen* fill-style "blue")
         (clog *screen*)
         (redraw))

       (defun game-turn (angle)
         ;;(clogf "take a turn, angle: " angle)
         (actor-move (sublayer-named *actors* "Player") angle)
         (redraw))

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
       )))


