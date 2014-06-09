(defun main (&rest args)
            (declare (ignore args))
	(let ((range (range 1 101)))
		(-
			(->
			  range
			  sum
			  (expt 2))
			(->>
				range
				(mapcar [expt _ 2])
				sum))))

