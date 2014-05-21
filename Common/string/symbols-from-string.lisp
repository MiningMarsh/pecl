(defun symbols-from-string (string)
"Converts a string into a list of symbols."
	(with-input-from-string (in string)
		(loop for x = (read in nil nil) while x collect x)))
