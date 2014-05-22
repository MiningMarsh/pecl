(defun main (&rest args)
            (declare (ignore args))
	(let ((range (range 1 101)))
		(-
			(->>
				range
				(mapcar 

