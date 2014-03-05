(defun unnest (value)
	(if value
		(let ((rest (unnest (cdr value)))
		      (first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc first rest)))
		(list)))
