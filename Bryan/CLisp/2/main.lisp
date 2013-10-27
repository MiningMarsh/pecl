(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defun main ()
  (reduce #'+ (remove-if-not (lambda (x) (and (evenp x) (< x 4000000))) (fib-list 100))))

