(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "n! means n × (n − 1) × ... × 3 × 2 × 1
For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
Find the sum of the digits in the number 100!")
(defun main ()
 (reduce
  (lambda (acc x) (+ (char-to-number x) acc))
  (format nil "~a" (factorial 100))
  :initial-value 0))
