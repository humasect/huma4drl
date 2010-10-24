(defpackage :gamelike-asd)
(in-package :gamelike-asd)

(asdf:defsystem gamelike
  :name "Gamelike"
  :version "1.0"
  :maintainer "Lyndon Tremblay"
  :author "Lyndon Tremblay"
  :license "General Public License (GPL) Version 3"
  :description "humasect's 4-Day Roguelike"
  :serial t
  :depends-on (:cl-who :parenscript)
  :components ((:file "output")
               (:file "gamelike-html")
               (:file "main-js")
               (:file "anim-js")))