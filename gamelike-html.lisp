(require :cl-who)
(require :parenscript)
(in-package "LGamelike")

(defun index-html (stream)
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
                  (:script :type "text/javascript"
                           (str (ps* `(progn
                                        (var hehe 4)))))
                  (:script :src "main.js"))
           (:body
            (:h2 "humasect 4drl")

            (:div :id "view")))))

(defun output-index ()
  (output-file "gamelike.html" #'index-html))

;; (defun serve ()
;;   (hunchentoot:define-easy-handler (serve-game :uri "/") ()
;;     (setf (hunchentoot:content-type*) "text/plain")
;;     (index-html))
;;   (hunchentoot:start (make-instance 'hunchentoot:acceptor :port 9090)))

