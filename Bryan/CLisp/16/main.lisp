(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
What is the sum of the digits of the number 2^1000?")



(defun main ()
 (reduce
  (lambda (acc x) (+ (char-to-number x) acc))
  (format nil "~a" (expt 2 1000))
  :initial-value 0))
