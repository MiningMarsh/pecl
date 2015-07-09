(defmacro let1 (var bind &body body)
	`(let ((,var ,bind))
		,@body))

(verify-macro
	(let1 var value
		body)
	(let ((var value))
		body))
