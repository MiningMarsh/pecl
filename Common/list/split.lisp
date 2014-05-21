(defun split (list &optional (at nil at-provided-p))
"Returns the list split at the specified point."
	(let 
			((at
				(if at-provided-p
					at
					(-> list length (/ 2) ceiling)))
			(start (list 0)))
		(do* 
				((length 0 (1+ length))
				(head start (cdr (nconc head (list (car tail)))))
				(tail list (cdr tail)))
			((or (not tail) (>= length at)) (values (cdr start) tail)))))
