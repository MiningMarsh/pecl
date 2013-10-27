(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
")
(defun multiple-3-or-5 (x)
  (or (zerop (rem x 3)) (zerop (rem x 5))))
(defun main()
 (reduce #'+ (remove-if-not #'multiple-3-or-5 (range 1 1000))))
