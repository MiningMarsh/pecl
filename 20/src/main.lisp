(defun main (&rest args)
	(declare (ignore args))
	(apply #'+
		(digits
			(factorial 100))))
