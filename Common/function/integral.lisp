(defun integral (f &optional (x nil x-defined-p))
	(let*
			((delta (if (< x 0 ) -0.01 0.01))
			(ff (lambda (x)
				(reduce-range
					(lambda (acc n)
						(+ acc (* (funcall f n) delta)))
					0
					(+ x delta)
					:step delta))))
		(if x-defined-p
			(funcall ff x)
			ff)))
