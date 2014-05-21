(defun divisors (n)
"Returns a list of the divisors of n."
	(let ((max (floor (sqrt n))))
		(labels
				((internal (low high current)
					(if (> current max)
						(append (reverse low) high)
						(if (= 0 (mod n current))
							(internal (cons current low) (cons (/ n current) high) (1+ current))
							(internal low high (1+ current))))))
			(internal (list 1) (list n) 2))))
