(require :cl-who)
(require :parenscript)
(in-package "LGamelike")

(defmacro main-js ()
  `(progn (defun create-map ()
            4)))

(defun output-main ()
  (output-file "main.js" (lambda (Stream)
                           (setf *parenscript-stream* Stream)
                           (ps* (macroexpand-1 '(main-js))))))
