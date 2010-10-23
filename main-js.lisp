(require :cl-who)
(require :parenscript)
(in-package "LGamelike")

(defvar *tile-width* 24)
(defvar *tile-height* 30)
(defvar *map-width* 32)
(defvar *map-height* 24)

(defmacro for-each-tile (f xmod ymod)
  `(loop for i from 0 to *map-width*
      do (loop for j from 0 to *map-height*
            do (let ((x (+ (* i ,xmod) 64))
                     (y (+ (* j ,ymod) 64)))
                 (funcall ,f x y)))))

(defun for-each-tile-xy (f)
  (let ((xmod (lambda (x) (+ x 64)))
        (ymod (lambda (y) (+ y 64))))
    (for-each-tile f *tile-width* *tile-height*)))

(defun for-each-tile-element (f)
  (for-each-tile f 0 0))

(defmacro main-js ()
  `(progn
     (var *tile-width* ,*tile-width*)
     (var *tile-height* ,*tile-height*)
     (var *map-width* ,*map-width*)
     (var *map-height* ,*map-height*)

     (defun for-each-tile-xy (*fun)
       (loop for i from 0 to *map-width*
          do (loop for j from 0 to *map-height*
                do (*fun i j))))

     (defun create-map ()
       (for-each-tile-xy
        (lambda (x y)
          (let ((c ($"<div/>")))
            (chain c (attr "id" (concatenate 'string "tile_" x "_" y)))
            (chain ($ "#view") (append c))))))

     (chain ($ document) (ready create-map))))

(defun output-main ()
  (output-file "main.js" (lambda (Stream)
                           (setf *parenscript-stream* Stream)
                           (ps* (macroexpand-1 '(main-js))))))
