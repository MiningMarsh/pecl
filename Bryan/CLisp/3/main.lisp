(load (compile-file "math-util.lisp"))
(defun main ()
(format t "~a~%" (prime-factors 600851475143))
)
