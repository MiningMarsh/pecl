(defun main (&rest args)
	(declare (ignore args))
	(reduce-range
		[if (or (= 0 (mod %2 5)) (= 0(mod %2 3)))
			(+ %2 %1)
			%1]
		1
		1000
		:initial-value 0))
