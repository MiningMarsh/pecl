(defmacro labels1 ((name params &body innerbody) &body body)
"LABELS1 is a shorthand for LABELS where you only need one function defined.

(labels1 (func (arg) arg)
	(func 5))
=> 5"
	`(labels ((,name ,params
			,@innerbody))
		,@body))

(verify-macro
	(labels1 (func (arg1 arg2)
			body)
		(func value1 value2))

	(labels ((func (arg1 arg2)
			body))
		(func value1 value2)))
