(defun unnest (value)
"Unnests every sublist of a list. Like flatten, but does not flatten
sublists."
	(mappend #'mklist value))
