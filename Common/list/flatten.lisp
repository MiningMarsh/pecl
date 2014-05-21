(defun flatten (value)
"Flattens a list: (1 (2 3 (5) 6)) -> (1 2 3 5 6)"
	(if value
		(let ((rest (flatten (cdr value)))
		      (first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc (flatten first) rest)))
		(list)))
