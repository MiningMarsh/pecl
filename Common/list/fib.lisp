(defun-memoized fib (nth)
	(if (< nth 3)
		1
		(+ (fib (- nth 1)) (fib (- nth 2)))))
