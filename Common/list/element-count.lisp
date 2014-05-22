(defun element-count (list)
	(let ((table (make-hash-table)))
		(labels
				((internal (list)
					(if (not list)
						(hash-pairs table)
						(progn
							(setf
								(gethash (car list) table)
								(if (gethash (car list) table)
									(+ 1 (gethash (car list) table))
									1))
							(internal (cdr list))))))
			(internal list))))
