(defun diagonal (xss &optional (row nil row-provided-p))
"Returns the diagonals of a matrix, travelling from the bottom left towards the
 upper right. Takes an optional argument specifiying the nth diagonal to return,
 in case you only need that one. Specifying a row is more efficient than calling
 nth on all the diagonals."
	(if row-provided-p
		(labels 
				((diagonal (xss n acc)
					(if (= 0 n)
						acc
						(let ((head (car xss)) (tail (cdr xss)))
						(diagnol
							tail
							(1- n)
							; TODO: This can be done with a single pass of each
							;       list. This needs to be done, otherwise we
							;       might as well be calling nth on diagonals.
							(if (>= (length head) n)
								(cons (nth (1- n) head) acc)
								acc))))))
			(diagonal xss (1+ row) nil))
		(labels
				((diagonals (xss xssacc acc)
					(let
							((xssacc
								(if xss
									(cons (car xss) xssacc)
									xssacc)))
						(if (and (not xss) (not xssacc))
							(nreverse acc)
							(diagonals
								(cdr xss)
								(remove-nil (mapcar #'cdr xssacc))
								(cons (mapcar #'car xssacc) acc))))))
			(diagonals xss nil nil))))
