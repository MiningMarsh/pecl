(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp" :verbose nil)))

(setq *project-description* "By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
that the 6th prime is 13.
What is the 10 001st prime number?")

(defun main ()
	(car (last (n-primes 10001))))
