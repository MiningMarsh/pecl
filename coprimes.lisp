
(defun triplet (n m)
"Generates a pythagorean triple from given coprimes of different parity."
	(list
		(- (* m m) (* n n))
		(* 2 m n)
		(+ (* m m) (* n n))))

(defun calc-boundary (x)
"Calculate the largest , in a coprime of (n m) that could result in a triple 
adding to x"
	(ceiling (/ (- (sqrt (+ (* 2 x) 1)) 1) 2)))
	

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

(print (time (apply #'* (car (get-triplets 1000)))))
