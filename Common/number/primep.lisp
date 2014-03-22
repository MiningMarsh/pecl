(defun primep (num)
	(reduce 
		[and %1 %2]
		(mapcar 
			[= 0 (mod num _)]
			(range 2 (- num 1)))))
