(defun number-from-digits (digits)
	(reduce ~(+ (* 10 %1) %2) digits))
