(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defvar *project-description*)
(setq *project-description* "A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.")

(defun abundantp (n)
  (< n (sum (proper-divisors n))))


(defun crawler (m)
  (let* ((a (list-to-array (remove-if-not #'abundantp (range 2 (1+ m))))) (b (array-dimension a 0)))
	(labels
		((rec (i j hash)
		   (cond
			 ((>= j b) (rec (1+ i) 0 hash))
			 ((>= i b) (crawler-phase-2 hash m))
			 (t (rec i (1+ j) (progn (setf (gethash (+ (aref a i) (aref a j)) hash) t) hash))))))
	  (rec 0 0 (make-hash-table)))))

(defun crawler-phase-2 (hash m)
  (reduce (lambda (acc m) (if (not (gethash m hash)) (+ acc m) acc)) (range 1 (1+ m))))

(defun main ()
  (crawler 28123))
