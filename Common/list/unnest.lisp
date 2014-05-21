(defun unnest (value)
"Unnests every sublist of a list. Like flatten, but does not flatten
sublists."
	(if value
		(let 
				((rest (unnest (cdr value)))
				(first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc first rest)))
		(list)))
