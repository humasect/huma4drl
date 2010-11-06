(defpackage :huma4drl
  (:documentation "humasect 4-day roguelike")
  (:nicknames :4drl)
  (:use :common-lisp :cl-who :parenscript :humaweb)
  (:export output))

(in-package :huma4drl)

(defparameter *js-files* '("actor" "map" "game"))
(defparameter *css-files* '("style"))

(defun output (&key (dir "../huma4drl_gh-pages"))
  (output-project :dir dir
                  :width 32
                  :height 24
                  :scale 32
                  :html '("play")
                  :js *js-files*
                  ; :css *css-files*
                  ))

(define-htmloutput play
    :title "humasect 4drl"
    :styles *css-files*
    :scripts *js-files*
    :body (htm
           (:h2 "humasect 4drl")
           (:canvas
            :id "screen-canvas"
            :width (* *screen-width* *layer-scale*)
            :height (* *screen-height* *layer-scale*))))


(define-jsoutput game
  (var *pieces* nil)
  (var *actors* nil)
  
  (defun redraw ()
    (layer-render *screen*))

  (defun start-main ()
    ;; set up temp level pieces
    (setf *pieces* (layer-new :name "*pieces*" :contents 'empty))
    (layer-add-sublayer *screen* *pieces*)
    (layer-add-sublayers *pieces*
                         (list (layer-new
                                :name "test-left"
                                :fill-style "red"
                                :bounds (rect-make 5 10 5 5))
                               (layer-new
                                :name "test-right"
                                :fill-style "green"
                                :bounds (rect-make 20 10 5 5))))
    
    ;; set up actors
    (setf *actors* (layer-new :name "*actors*" :contents 'empty))
    (layer-add-sublayer *screen* *actors*)
    (layer-add-sublayers *actors* (list (actor-new "Player" "@" 2 2)
                                        (actor-new "Monster" "M" 10 10)))

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
  )
