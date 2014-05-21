(defun-memoized fib (nth)
	(cond
		((< nth 1) 0)
		((< nth 3) 1)
		(t (+ (fib (- nth 1)) (fib (- nth 2))))))
