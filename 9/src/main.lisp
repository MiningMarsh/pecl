(defun main (&rest args)
            (declare (ignore args))
	(format t "~A~%" (apply #'* (car (get-triplets 1000)))))
