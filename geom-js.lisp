(in-package :gamelike)

(defpsmacro min (x y) `(if (> ,x ,y) ,x ,y))
(defpsmacro max (x y) `(if (> ,x ,y) ,x ,y))

;; point
(defpsmacro point-make (x y) `(create x ,x y ,y))
(defpsmacro point-makef (x y f) `(create x (,f ,x) (,f ,y)))
(defpsmacro point-x (p) `(@ ,p x))
(defpsmacro point-y (p) `(@ ,p y))
;; (defpsmacro point-scr-x (p) `(* (@ ,p x) *tile-width*))
;; (defpsmacro point-scr-y (p) `(* (@ ,p y) *tile-height*))

(defpsmacro point-to-screen (p)
  `(point-make (* (.x p) *tile-width*)
               (* (.y p) *tile-height*)))

(defpsmacro .x (p) `(@ ,p x))
(defpsmacro .y (p) `(@ ,p y))

;; size
(defpsmacro size-make (w h) `(create width ,w height ,h))
(defpsmacro size-width (s) `(@ ,s width))
(defpsmacro size-height (s) `(@ ,s height))

;; rect
(defpsmacro rect-make (x y w h)
  `(create origin (point-make ,x ,y) size (size-make ,w ,h)))
;;(defpsmacro #x (r) `(.x (@ ,r origin)))
;;(defpsmacro #y (r) `(.y (@ ,r origin)))
(defpsmacro rect-origin (r) `(@ ,r origin))
(defpsmacro rect-size (r) `(@ ,r size))
(defpsmacro rect-x (r) `(point-x (rect-origin ,r)))
(defpsmacro rect-y (r) `(point-y (rect-origin ,r)))
(defpsmacro rect-width (r) `(size-width (rect-size ,r)))
(defpsmacro rect-height (r) `(size-height (rect-size ,r)))
(defpsmacro rect-max-x (r) `(+ (rect-x ,r) (rect-width ,r)))
(defpsmacro rect-max-y (r) `(+ (rect-y ,r) (rect-height ,r)))

(defmacro geom-js ()
  `(progn
     ;; misc
     (defun deg-to-rad (c) (/ (* c pi) 180.0))
     (defun rad-to-deg (c) (/ (* c 180.0) pi))

     ;;
     ;; point
     ;;

     (defun point-mod (p fun)
       (point-make (fun (.x p)) (fun (.y p))))

     (defun point-mod-with (p fun)
       (point-make (fun (.x a) (.x b))
                   (fun (.y a) (.y b))))

     (defun point-dot (a b)
       (+ (* (.x a) (.y b))
          (* (.y a) (.y b))))

     (defun point-magnitude (p)
       (sqrt (point-dot p p)))

     (defun point-divide (p s)
       (point-make (/ (@ p x) s)
                   (/ (@ p y) s)))

     (defun point-add (a b)
       (point-make (+ (@ a x) (@ b x))
                   (+ (@ a y) (@ b y))))

     (defun point-subtract (a b)
       (point-make (- (@ a x) (@ b x))
                   (- (@ a y) (@ b y))))

     (defun point-scale (p s)
       (point-make (* (@ p x) s)
                   (* (@ p y) s)))

     (defun point-normal (p)
       (var m (point-magnitude p))
       (if (not (= m 0))
           (point-divide p m)
           p))

     (defun point-rotate (p te)
       (let ((ct (cos te))
             (st (sin te)))
         (create x (- (* ct (@ p x)) (* st (@ p y)))
                 y (+ (* st (@ p x)) (* ct (@ p y))))))

     (defun point-angle-between (first second)
       (let ((diff (point-subtract second first)))
         (atan2 (@ diff x) (@ diff y))))

     (defun point-snap (p sz)
       (with-slots (x y) p
         (point-make (* (round (/ x sz)) sz)
                     (* (round (/ y sz)) sz))))

     ;;
     ;; random
     ;;
     (defun random-signed ()
       (- (* (random) 2) 1))

     (defun random-in-range (min max)
       ;; check that min is smoller than max
       (+ min (* (randam) (- max min))))

     (defun random-point-in-rect (x y w h)
       (point-make  (random-in-range x (+ x w))
                    (random-in-range y (+ y w))))

     (defun random-point-in-circle (x y radius)
       (let ((p (point-normal (point-make (random-signed) (random-signed)))))
         (point-add (point-scale p radius) (point-make x y))))

     ;;
     ;; etc
     ;;
     (defun keep-point-in-rect (p r)
       (point-make (cond ((< (.x p) (rect-x r)) (rect-x r))
                         ((> (.x p) (rect-max-x r)) (rect-max-x r))
                         (t (.x p)))
                   (cond ((< (.y p) (rect-y r)) (rect-y r))
                         ((> (.y p) (rect-max-y r)) (rect-max-y r))
                         (t (.y p)))))

     ))

(defun output-geom ()
  (output-js "geom" '(geom-js)))
