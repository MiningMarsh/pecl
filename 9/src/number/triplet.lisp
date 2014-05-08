(defun triplet (n m)
"Generates a pythagorean triple from given coprimes of different parity."
	(list
		(- (* m m) (* n n))
		(* 2 m n)
		(+ (* m m) (* n n))))
