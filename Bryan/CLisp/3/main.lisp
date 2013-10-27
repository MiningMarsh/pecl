(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defun main ()
  (prime-factors 600851475143))

