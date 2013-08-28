(load (compile-file "util.lisp" :verbose nil))
(defun fib-list (x &optional (acc (list 1 0)))
  (cond ((= x 0) '())
        ((= x 1)  (nreverse (cdr acc)))
        (t (fib-list (- x 1) (cons (+ (car acc) (cadr acc)) acc)))))

(declaim (inline divisible))
(defun divisible (n x)
  (declare (integer n) (integer x))
  (zerop (rem n x)))

(defun prime-factors (x)
  (labels ((rec (x upb i acc)
			 (cond
			   ((> i upb)	 (nreverse (cons x acc)))
			   ((divisible x i) (rec (/ x i) (sqrt x) i (cons i acc)))
			   (t (rec x upb (1+ i) acc)))))
	(rec x (sqrt x) 2 nil)))

(defun pi-1 (n)
  (declare (fixnum n))
  (round (exp (- (w-1 (/ -1.0d0 n))))))

(defun n-primes (n)
  (declare (fixnum n) (optimize (speed 3)))
  (if (< n 15)
	  (take n '(2 3 5 7 11 13 17 19 23 29 31 37 41 47))
	  (let ((pl (primes<n (pi-1 n))))
		(take n pl))))

(declaim (inline square))
(defun square (n)
  (declare (number n))
  (* n n))

(defun W (x)
  (+
   x
   (- (square x))
   (* 1.5 (expt x 3))
   (- (* (/ 8 3) (expt x 4)))
   (* (/ 125 24) (expt x 5))))


(defun W-1 (z)
  "SEE 'Numerical evaluation of the lamber w function and application
 to generation of generalized gaussian noise with exponent 1/2'"
 (declare (double-float z))
  (cond
	((and (< z -0.333) (>= z (/ -1 (exp 1))))
	 (let ((p (- (sqrt (* 2 (1+ (* (exp 1) z)))))))
	   (declare (double-float p))
	   (+ 
		-1 
		p 
		(- (* 1/3 (expt p 2)))
		(* 11/72 (expt p 3))
		(- (* 43/540 (expt p 4)))
		(* 769/17280 (expt p 5))
		(- (* 221/8505 (expt p 6))))))
	((and (<= -0.333 z) (<= z -0.033))
	 (/
	  (+
	   -8.0960
	   (* 391.0025 z)
	   (- (* 47.4252 (square z)))
	   (- (* 4877.6330 (expt z 3)))
	   (- (* 5532.7760 (expt z 4))))
	  (+
	   1
	   (- (* 82.9423 z))
	   (* 433.8688 (square z))
	   (* 1515.3060 (expt z 3)))))
	((and (< -0.033 z) (< z 0))
	 (let ((l1 (log (- z))) (l2 (log (- (log (- z))))))
	   (declare (double-float l1) (double-float l2)) 
	   (+
		l1
		(- l2)
		(/ l2 l1)
		(/ (* (+ -2 l2) l2) 
		   (* 2 (square l1)))
		(/ (* l2 (+ 6 (* -9 l2) (* 2 (square l2)))) 
		   (* 6 (expt l1 3)))
		(/ (* l2 (+ -12 (* 36 l2) (* -22 (square l2)) (* 3 (expt l2 3))))
		   (* 12 (expt l1 4)))
		(/ (* l2 (+ 60 (* -300 l2) (* 350 (square l2)) (* -125 (expt l2 3)) (* 12 (expt l2 4))))
		   (* 60 (expt l1 5))))))))

(defun perfect-squarep (n)
  (= (square (isqrt n)) n))

(defun hypot (a b)
  (sqrt (+ (square a) (square b))))

(defun ihypot (a b)
  (isqrt (+ (square a) (square b))))

(defun primes<n (n)
  (declare (fixnum n)(optimize (speed 3) (safety 0)))
  (let ((upb (isqrt n)))
	(declare (fixnum upb))
	(labels ((rec (p xs acc)
			   (declare (fixnum p) (list xs) (list acc))
			   (if (> p  upb)
				   (nconc (nreverse acc) xs)
				   (let ((nl (remove-if (lambda (x) (divisible x p)) xs)))
					 (declare (list nl))
					 (rec (car nl) nl (cons p acc))))))
	  (rec 2 (range 2 (1+ n)) nil))))

