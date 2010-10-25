(in-package :gamelike)

(defmacro apply-point (p f)
  `(,f (@ ,p x) (@ ,p y)))

(defpsmacro point-make (x y) `(create x ,x y ,y))
(defpsmacro point-x (p) `(@ ,p x))
(defpsmacro point-y (p) `(@ ,p y))
(defpsmacro point-scr-x (p) `(* (@ ,p x) *tile-width*))
(defpsmacro point-scr-y (p) `(* (@ ,p y) *tile-height*))

(defmacro geom-js ()
  `(progn
     ;; misc
     (defun deg-to-rad (c)
       (/ (* c pi) 180.0))
     (defun rad-to-deg (c)
       (/ (* c 180.0) pi))

     ;;
     ;; point
     ;;
     (defun point-makef (x y fun)
       (create x (fun x) y (fun y)))

     (defun point-mod (p fun)
       (create x (fun (@ p x))
               y (fun (@ p y))))

     (defun point-mod-with (p fun)
       (create x (fun (@ a x) (@ b x))
               y (fun (@ a y) (@ b y))))

     (defun point-dot (a b)
       (+ (* (@ a x) (@ b x))
          (* (@ a y) (@ b y))))

     (defun point-magnitude (p)
       (sqrt (point-dot p p)))

     (defun point-divide (p s)
       (create x (/ (@ p x) s)
               y (/ (@ p y) s)))

     (defun point-add (a b)
       (create x (+ (@ a x) (@ b x))
               y (+ (@ a y) (@ b y))))

     (defun point-subtract (a b)
       (create x (- (@ a x) (@ b x))
               y (- (@ a y) (@ b y))))

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
     ;; size
     ;;
     (defun size-make (w h)
       (create width w height h))

     ;;
     ;; rect
     ;;
     (defun rect-make (x y w h)
       (create origin (point-make x y) size (size-make w h)))
     (defun rect-min-x (r)
       (@ r origin x))
     (defun rect-min-y (r)
       (@ r origin y))
     (defun rect-max-x (r)
       (+ (@ r origin x) (@ size width)))
     (defun rect-max-y (r)
       (+ (@ r origin y) (@ size height)))
     ;;
     ;; random
     ;;
     (defun random-signed ()
       (- (* (random) 2) 1))

     (defun random-in-range (min max)
       ;; check that min is smoller than max
       (+ min (* (randam) (- max min))))

     (defun random-point-in-rect (x y w h)
       (create x (random-in-range x (+ x w))
               y (random-in-range y (+ y w))))

     (defun random-point-in-circle (x y radius)
       (let ((p (point-normal (point-make (random-signed) (random-signed)))))
         (point-add (point-scale p radius) (point-make x y))))

     ))

(defun output-geom ()
  (output-js "geom" '(geom-js)))
