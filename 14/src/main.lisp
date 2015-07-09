(defun main (&rest args)
	(declare (ignore args))
	(reduce
		~(if (> (cdr %1) (cdr %2))
			%1
			%2)
		(mapcar
			~(cons
				_
				(length (collatz _)))
			(range 1 1000001))))
