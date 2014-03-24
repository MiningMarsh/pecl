(defun-memoized factorial (nth)
"Computes the nth factorial, this is memoized due to how large factorials."
	; Since we are memoizing the thing, go ahead and make this non TCO, that
	; way calling (factoial n) also memoizes (factorial (- n 1)) etc.
	(if (= 0 nth)
		1; Base case.
		(* nth (factorial (1- nth)))))
