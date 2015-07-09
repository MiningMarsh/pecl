(defmacro labels1 ((name params &body innerbody) &body body)
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
