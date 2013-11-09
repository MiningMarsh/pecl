(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defvar *project-description*)
(setq *project-description* "
Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
Evaluate the sum of all the amicable numbers under 10000.
")

(defun amicablep-hashed (n hash)
  (let ((l (gethash (apply #'+ (proper-divisors n)) hash)))
	(and (eql l n) (not (eql n (apply #'+ (proper-divisors n)))))))

(defun store-divisors (max hash)
  (mapcar
   (lambda (n) (setf
				(gethash n hash)
				(apply #'+ (proper-divisors n))))
   (range 2 (1+ max)))
  hash)

(defun main ()
  (let ((l (store-divisors 10000 (make-hash-table))))
	(apply #'+ (remove-if-not (lambda (n) (amicablep-hashed n l)) (range 2 10001)))))
		   
