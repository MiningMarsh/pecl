(defun main (&rest args)
	(declare (ignore args))
	(apply #'+ (digits (expt 2 1000))))
