(defun-memoized factorial (nth)
"Computes the nth factorial, this is memoized due to how lare factorials get
very quickly."
	; Since we are memoizing the thing, go ahead and make this non TCO, that
	; way calling (factoial n) also memoized (facotorial (- n 1)) etc.
	(if (= 0 nth)
		1
		(* nth (factorial (1- nth)))))
