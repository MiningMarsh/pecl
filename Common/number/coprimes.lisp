(defun coprimes (max)
"Returns a list of coprime pairs (n m) where n < m, and every m < max."
	(labels 
			((recurse (acc n m)
				(if (> m max)
					acc
					(cons (list n m)
						(recurse 
							(recurse
								(recurse acc m (+ (* 2 m) n))
								n (+ m (* 2 n)))
							m (- (* 2 m) n))))))
		(recurse (recurse nil 1 2) 1 3)))
