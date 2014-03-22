(defun flatten (value)
	(if value
		(let ((rest (flatten (cdr value)))
		      (first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc (flatten first) rest)))
		(list)))
