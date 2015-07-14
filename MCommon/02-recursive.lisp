(defmacro recursive (args init &rest code)
"RECURSIVE creates a recuring form, starting with a list of arguments, then a
list of their initial values, then a list of forms to evaluate. The function
RECUR is bound before evaluation of the forms, calling RECUR with a list of
arguments will cause RECURSIVE form to recurse.

(recursive (n) (5)
	(if ( = n 0)
		0
		(+ n (recur (1- n)))))
=> 15"
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
