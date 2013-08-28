(load (compile-file "math-util.lisp"))

(setq *project-description* "The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.")
(defun main ()
  (format t "~a~%" (apply #'+ (primes<n 2000000))))
