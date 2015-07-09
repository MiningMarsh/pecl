(defmacro recursive (args init &rest code)
	`(labels1
			(recur ,args
				,@code)
		(recur ,@init)))

(verify-macro
	(recursive (arg1 arg2 arg3) (value1 value2 value3)
		body)
	(labels1 (recur (arg1 arg2 arg3)
			body)
		(recur value1 value2 value3)))
