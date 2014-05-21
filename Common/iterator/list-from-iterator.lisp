(defun list-from-iterator (iterator)
	(nreverse 
		(reduce-iterator
			[cons %2 %1]
			iterator
			:initial-value nil)))
