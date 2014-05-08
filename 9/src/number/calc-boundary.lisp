(defun calc-boundary (x)
"Calculate the largest , in a coprime of (n m) that could result in a triplet
adding to x"
	(ceiling (/ (- (sqrt (+ (* 2 x) 1)) 1) 2)))
