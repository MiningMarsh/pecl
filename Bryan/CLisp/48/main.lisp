(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defvar *project-description*)
(setq *project-description* "The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.")
(defun main ()
  (let ((s (format nil "~a" (sum (mapcar (lambda (n) (expt n n)) (range 1 1000))))))
		   (subseq s (- (length s) 10))))
