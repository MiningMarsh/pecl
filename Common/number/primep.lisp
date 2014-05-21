(defun primep (n)
"Tests whether n is a prime number."
	(cond
		((= 1 n) t)
		((= 2 n) t)
		(t 
			(reduce 
				[and %1 %2]
				(mapcar 
					[= 0 (mod num _)]
					(range 2 (sqrt num)))))))
