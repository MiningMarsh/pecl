(defun remove-nil (list)
"Removes all empty sublists from a list."
	(remove-if-not #'identity list))
