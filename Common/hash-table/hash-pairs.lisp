(defun hash-pairs (hash-table)
	(mapcar 
		[list _ (gethash _ hash-table)]
		(hash-keys hash-table)))
