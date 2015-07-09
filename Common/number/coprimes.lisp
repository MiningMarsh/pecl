(defun coprimes (max)
"Returns a list of coprime pairs (n m) where n < m, and every m < max."
	(labels 
			((recur (acc n m)
				(if (> m max)
					acc
					(cons (list n m)
						(recur 
							(recur
								(recur acc m (+ (* 2 m) n))
								n (+ m (* 2 n)))
							m (- (* 2 m) n))))))
		(recur (recur nil 1 2) 1 3)))
