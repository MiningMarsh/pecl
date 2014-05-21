(defun derivative (f &optional (x nil x-defined-p))
"Returns the derivative of function f, or return the derivative of f at 
point x."
	; This delta was hand tweaked to provide accurate results
	(let*
			((delta 0.001)
			(df
				[->
					f
					(funcall (+ _ delta))
					(- (funcall f _))
					(/ delta)]))
		(if x-defined-p
			(funcall df x)
			df)))
