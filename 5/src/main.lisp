(defun main (&rest args)
            (declare (ignore args))
	(let ((range (range 2 21)))
		(mul
			(mapcar
				~(apply #'expt _)
				(->
					~(-> _ prime-factors element-count)
					(mapcar range)
					unnest
					largest-count)))))

