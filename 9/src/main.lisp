(defun main (&rest args)
            (declare (ignore args))
	(apply #'* (car (get-triplets 1000))))
