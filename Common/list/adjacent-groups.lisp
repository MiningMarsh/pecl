(defun adjacent-groups (list &optional (size 0 size-provided-p))
                       (declare (type list list)
                                (type fixnum size)
                                (type boolean size-provided-p))
	(if (not size-provided-p)
		(->>
			(length list)
			1+
			range
			(mapcar ~(adjacent-groups list _))
			unnest)
		(recursive (n acc list) ((length list) nil list)
			(if (< n size)
				acc
				(recur
					(- n 1)
					(cons (take size list) acc)
					(cdr list))))))
