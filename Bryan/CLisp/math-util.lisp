(load (compile-file "util.lisp" :verbose nil :print nil))
(defun fib-list (x &optional (acc (list 1 0)))
  (cond ((= x 0) '())
        ((= x 1)  (nreverse (cdr acc)))
        (t (fib-list (- x 1) (cons (+ (car acc) (cadr acc)) acc)))))

(defun primep (n)
  (labels ((rec (n c upb)
			 (if (> c upb)
				 t
				 (if (divisible n c)
					 nil
					 (rec n (+ c 2) upb)))))
	(cond
	  ((= n 2) t)
	  ((divisible n 2) nil)
	  ((< n 2) nil)
	  (t (rec n 3 (isqrt n))))))		


(defun prime-factors (x)
  (labels ((rec (x upb i acc)
			 (cond
			   ((> i upb)	 (nreverse (cons x acc)))
			   ((divisible x i) (rec (/ x i) (sqrt x) i (cons i acc)))
			   (t (rec x upb (1+ i) acc)))))
	(rec x (sqrt x) 2 nil)))


(defun fast-divisible (x xs)
  (declare (values boolean) ((unsigned-byte 32) x) (list xs) (optimize (speed 3) (safety 0)))
  (let ((u (isqrt x)))
	(declare ((unsigned-byte 32) u) (optimize (speed 3) (safety 0)))
	(if (null xs)
		nil
		(labels
			((rec (xs)
			   (let ((h (car xs)))
				 (declare ((unsigned-byte 30) h))
				 (if (or (> h u) (null xs))
					 nil
					 (if (zerop (rem x h))
						 t
						 (rec (cdr xs)))))))
		  (rec xs)))))

(defun fast-sieve (n)
  (declare (values list) (fixnum n) (optimize (speed 3) (safety 0) (debug 0)))
  (labels
	  ((rec (pq nums)
		 (declare (values list) (queue pq) (list nums) (optimize (speed 3) (safety 0) (debug 0)))
		 (if (null nums)
			 (queue-first pq)
			 (if (fast-divisible (car nums) (queue-first pq))
				 (rec pq (cdr nums))
				 (rec (enqueue pq (car nums)) (cdr nums))))))
	(rec (make-queue) (cons 2 (range 3 n 2)))))



(defun factors (x)
  (let ((upb (sqrt x)))
	(labels ((rec (n acc)
			   (if (> n upb)
				   acc
				   (if (divisible x n)
					   (if (= n upb)
						   (rec (1+ n) (cons n acc))
						   (rec (1+ n) (cons n (cons (/ x n) acc))))
					   (rec (1+ n) acc)))))
	  (rec 1 nil))))

(defun proper-divisors (n)
  (remove n (factors n)))

(defun pi-1 (n)
  (declare (fixnum n))
  (let ((x (round (exp (- (w-1 (/ -1.0d0 n)))))))
	(declare (fixnum x))
	x))

(defun n-primes (n)
  (declare (fixnum n) (optimize (speed 3) (safety 0)))
  (if (< n 15)
	  (take n '(2 3 5 7 11 13 17 19 23 29 31 37 41 47))
	  (let ((pl (fast-sieve (pi-1 n))))
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
  (fast-sieve n))


(defun triangle-numbers (n)
  (labels ((rec (x acc)
			 (if (>= x (1+ n))
				 (nreverse acc)
				 (rec (1+ x) (cons (+ x (car acc)) acc)))))
	(rec 2 (list 1))))

(defun collatz (start)
  (collect-list (= start 1)
				(if (evenp start)
					(/ start 2)
					(+ 1 (* 3 start)))
				start))

(defun factorial (n)
  (labels
	  ((rec (x n)
		 (if (= n 0)
			 x
			 (rec (* x n) (1- n)))))
	(rec 1 n)))

(defun reduce-two-rows (xs ys)
  (mapcar
   (lambda (x y1 y2)
	 (if (>= (+ x y1) (+ x y2))
		 (+ x y1)
		 (+ x y2)))
   xs ys (cdr ys)))

(defun reduce-step (triangle)
  (cons
   (reduce-two-rows (cadr triangle) (car triangle))
   (cddr triangle)))

(defun reduce-triangle (triangle)
  (if (= (length triangle) 1)
	  (caar triangle)
	  (reduce-triangle (reduce-step triangle))))

(defun sum (xs)
  (reduce #'+ xs))

(defun product (xs)
  (reduce #'* xs))

(defun divisible (x xs &rest xss)
  (if (atom xs)
      (divisible x (cons xs xss))
      (labels
          ((rec (xs)
             (if (null xs)
                 nil
                 (if (zerop (rem x (car xs)))
                     t
                     (rec (cdr xs))))))
        (rec xs))))

