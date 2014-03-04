(defun main (&rest args)
	(format t "~A~%" (reduce #'+ (remove-if-not #'evenp (fib 4000000)))))
