(defun triplet (n m)
"Generates a pythagorean triple from given coprimes of different parity."
	(let ((mm (* m m)) (nn (* n n)))
		(list
			(- mm nn)
			(* 2 m n)
			(+ mm nn))))
