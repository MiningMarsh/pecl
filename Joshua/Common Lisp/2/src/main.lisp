(defun main (&rest args)
            (declare (ignore args))
	(format t "~A~%" 
		(reduce 
			#'+ 
			(remove-if-not 
				#'evenp 
				(iterate #'+ '(1 1) :while (curry #'> 4000000))))))
