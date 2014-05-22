(defun hash-keys (hash-table)
	(loop for key being the hash-keys of hash-table collect key))
