(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
")

(defun multiple-3-or-5 (x)
  (divisible x 3 5))
(defun main()
  (reduce #'+ (remove-if-not #'multiple-3-or-5 (range 1 1000))))


(defun my-expt (n m)
  (labels
	  ((rec (acc n m)
		 (if (= m 1)
			 (* acc n)
			 (if (evenp m)
				 (rec acc (square n) (/ m 2))
				 (rec (* acc n) (square n) (/ (- m 1) 2))))))
	(rec 1 n m)))

(defun 2x2-matrix-multiply (n m)
  (var-bind (a b c d) n
	(var-bind (e f g h) m
	  (list
	   (+ (* a e) (* b g)) (+ (* a f) (* b h))
	   (+ (* c e) (* d g)) (+ (* c f) (* d h))))))

(defun 2x2-matrix-square (m)
  (2x2-matrix-multiply m m))

(defun 2x2-matrix-expt (m n)
  (labels
	  ((rec (acc m n)
		 (if (= n 1)
			 (2x2-matrix-multiply acc m)
			 (if (evenp n)
				 (rec acc (2x2-matrix-square m) (/ n 2))
				 (rec (2x2-matrix-multiply acc m) (2x2-matrix-square m) (/ (- n 1) 2))))))
	(rec '(1 0 0 1) m n)))

(defun fib (n)
  (labels
	  ((rec (a b n)
		 (if (= n 0)
			 a
			 (rec b (+ a b) (1- n)))))
	(rec 0 1 n)))

(defun fast-fib (n)
  (nth (- 1 (rem n 2)) (2x2-matrix-expt '(1 1 1 2) (ceiling (/ n 2)))))



