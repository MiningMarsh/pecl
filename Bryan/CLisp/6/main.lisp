(if (not (boundp *running-from-runner*))(
										 load (compile-file "math-util.lisp")))
(setq *project-description* "
The sum of the squares of the first ten natural numbers is,
1² + 2² + ... + 10² = 385

The square of the sum of the first ten natural numbers is, 
(1 + 2 + ... + 10)² = 552 = 3025

Hence the difference between the sum of the squares of the first ten natural 
numbers and the square of the sum is 3025 − 385 = 2640.

Find the difference between the sum of the squares of the first one hundred 
natural numbers and the square of the sum.
")
(defun main ()
  (-
   ((lambda (x) (* x x)) (apply #'+ (range 1 101)))
   (apply #'+ (mapcar (lambda (x) (* x x)) (range 1 101)))))
