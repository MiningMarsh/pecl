(defun get-triplets (target)
"Get every pythagorean triple that adds to max."
	(labels ((addition (coprime-pair)
			(apply
				(lambda (n m)
					(+ (* 2 m m) (* 2 m n)))
				coprime-pair)))
		(mapcar 
			(lambda (x) 
				(mapcar
					(lambda (y) (* y (/ target (addition x))))
					(apply #'triplet x)))
			(remove-if-not
				(lambda (x) (= 0 (mod target (addition x))))
				(coprimes (calc-boundary target))))))
