(defmacro let1 (var bind &body body)
"LET1 is a shorthand for LET where you only need one function defined.

(let1 x 5
	x)
=> 5"
	`(let ((,var ,bind))
		,@body))

(verify-macro
	(let1 var value
		body)

	(let ((var value))
		body))
