(defun largest-count (counts)
	(let ((table (make-hash-table)))
		(labels
				((internal (counts)
					(if (not counts)
						(hash-pairs table)
						(progn
							(let ((key (car (car counts))) (value (car (cdr (car counts)))))
								(setf
									(gethash key table)
									(if (gethash key table)
										(max value (gethash key table))
										value)))
							(internal (cdr counts))))))
			(internal counts))))
