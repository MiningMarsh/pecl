(defun adjacent-groups (list &optional (size nil size-provided-p))
	(if (not size-provided-p)
		(->>
			(length list)
			1+
			range
			(mapcar ~(adjacent-groups list _))
			unnest)
		(labels
				((internal (n acc list)
					(if (< n size)
						acc
						(internal 
							(- n 1) 
							(cons (take size list) acc) 
							(cdr list)))))
			(internal (length list) nil list))))
