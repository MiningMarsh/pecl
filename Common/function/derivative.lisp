(defun derivative (f &optional (x nil x-defined-p))
	; This delta was hand tweaked to provide accurate results
	(let*
			((delta 0.001)
			(df (lambda (x) 
				(/ 
					(- 
						(funcall f (+ x delta)) 
						(funcall f x)) 
					delta))))
		(if x-defined-p
			(funcall df x)
			df)))
