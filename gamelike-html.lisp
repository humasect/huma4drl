(require :cl-who)
(require :parenscript)
(in-package "LGamelike")

(defvar *tile-width* 24)
(defvar *tile-height* 30)
(defvar *map-width* 32)
(defvar *map-height* 24)

(defun css-tile-position (x y)
  (format nil "left: ~dpx; top: ~dpx;" x y))

(defmacro for-each-tile (f xmod ymod)
  `(loop for i from 0 to *map-width*
      do (loop for j from 0 to *map-height*
            do (let ((x (+ (* i ,xmod) 64))
                     (y (+ (* j ,ymod) 64)))
                 (funcall ,f x y)))))

(defun for-each-tile-xy (f)
  (for-each-tile f *tile-width* *tile-height*))

(defun index-html (stream)
  (cl-who:with-html-output (stream nil :indent t)
  ;;(with-html-output-to-string (s)
    (:html :manifest "cache.manifest"
           (:head (:title "humasect 4drl")
                  (:meta :name "keywords"
                   :content "Gamelike Role Playing Roleplaying RPG Roguelike")
                  (:link :rel "stylesheet" :type "text/css" :href "style.css")
                  (:script :src "jquery-1.4.2.min.js")
                  (:script :src "functional.min.js")
                  (:script :src "underscore-min.js")
                  (:script :type "text/javascript"
                           (str (ps* `(progn
                                        (var hehe 4)))))
                  (:script :src "main.js"))
           (:body
            (:h2 "humasect 4drl")

            (for-each-tile-xy
             (lambda (x y)
               (htm
                (:div :id (format nil "tile_~d_~d" x y)
                      :class "tile"
                      :style (conc (css-tile-position x y)
                                   "background:" (if (oddp y)
                                                     "blue"
                                                     "green"))
                      ;; :style (:left (* i 10) :top (* j 10))
                      (fmt "#")))))
            ))))

(defun output-index ()
  (output-file "gamelike.html" #'index-html))

;; (defun serve ()
;;   (hunchentoot:define-easy-handler (serve-game :uri "/") ()
;;     (setf (hunchentoot:content-type*) "text/plain")
;;     (index-html))
;;   (hunchentoot:start (make-instance 'hunchentoot:acceptor :port 9090)))

