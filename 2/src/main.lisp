(defun main (&rest args)
            (declare (ignore args))
		(reduce #'+ 
			(remove-if-not #'evenp 
				(iterate #'+ '(1 1) :while [> 4000000 _]))))
