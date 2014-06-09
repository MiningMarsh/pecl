(defun take (n list)
	(if (numberp n)
		(labels 
				((take (n list)
					(if list
						(if (<= n 0)
							nil
							(cons (car list) (take (- n 1) (cdr list))))
						nil)))
			(take n list))))
