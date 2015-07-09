(defmacro when-bind (var condition &body body)
	`(let1 ,var ,condition
		(when ,var
			@body)))

(verify-macro
	(when-bind var (condition)
		body)
	(let1 var (condition)
		(when var
			body)))
