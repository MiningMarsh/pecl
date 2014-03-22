(defun main (&rest args)
            (declare (ignore args))
	(format t "~A~%" (car (last (prime-factors 600851475143)))))
