(defun-memoized collatz (start)
"Returns the collatz sequence starting at start."
	(if (= start 1)
		(list 1)
		(cons
			start
			(collatz
				(if (evenp start)
					(/ start 2)
					(1+ (* 3 start)))))))
