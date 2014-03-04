(defun main (&rest args)
	(print (reduce #'+ (remove-if-not #'evenp (fib 4000000)))))
