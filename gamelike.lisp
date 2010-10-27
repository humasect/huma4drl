(defpackage :gamelike
  (:documentation "humasect 4-day roguelike")
  (:nicknames :gl)
  (:use :common-lisp :cl-who :parenscript :humaweb)
  (:export output-all))

(in-package :gamelike)

(defvar *tile-width* 32)
(defvar *tile-height* 32)
(defvar *screen-width* 32)
(defvar *screen-height* 24)

(defun output-all ()
  (output-project :dir "../huma4drl_gh-pages"
                  :html '("gamelike")
                  :js '("main" "actor" "map")))

(defun gamelike-html (stream)
  (cl-who:with-html-output (stream nil :indent t)
  ;;(with-html-output-to-string (s)
    (:html :manifest "cache.manifest"
           (:head (:title "humasect 4drl")
                  (:meta :name "keywords"
                   :content "Gamelike Role Playing Roleplaying RPG Roguelike")
                  (:link :rel "stylesheet" :type "text/css" :href "style.css")

                  (:script :src "jquery-1.4.2.min.js")
                  ;;(:script :src "functional.min.js")
                  (:script :src "underscore-1.1.0.min.js")
                  (:script :src "geom.js")
                  (:script :src "anim.js")
                  (:script :src "actor.js")
                  (:script :src "main.js"))
           (:body
            (:h2 "humasect 4drl")

            (:canvas :id "canvas"
                     :width *screen-width*
                     :height *screen-height*)))))

(defpsmacro point-to-screen (p x y)
  `(point-make (* (.x ,p) ,x) (* (.y ,p) ,y)))

(defpsmacro rect-to-screen (r x y)
  `(rect-make
    (* (rect-x ,r) ,x)
    (* (rect-y ,r) ,y)
    (* (rect-width ,r) ,x)
    (* (rect-height ,r) ,y)))
