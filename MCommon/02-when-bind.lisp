(defmacro when-bind (var condition &body body)
"WHEN-BIND takes a symbol, a condition, and a list of forms to evaluate.
The forms will be evaluated when the condition yields a true value, and the
symbol shall be bound to the result of the condition before the forms are
evaluated.

(when-bind rest (member 'c '(a b c d))
	rest)
=> (C D)"
	`(let1 ,var ,condition
		(when ,var
			,@body)))

(verify-macro
	(when-bind var (condition)
		body)

	(let1 var (condition)
		(when var
			body)))
