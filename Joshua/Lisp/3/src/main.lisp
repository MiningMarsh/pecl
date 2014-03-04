(defun main (&rest args)
	(format t "~A~%" (car (last (prime-factors 600851475143)))))
