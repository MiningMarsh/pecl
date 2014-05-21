(defun iterator-from-list (list)
	(let ((pointer list))
		[if (not pointer)
			(values nil t)
			(let ((value (car pointer))) 
				(setf pointer (cdr pointer))
				(values value nil))]))