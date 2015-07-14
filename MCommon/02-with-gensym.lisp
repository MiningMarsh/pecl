(defmacro with-gensym (var &body body)
	`(let1 ,var (gensym)
		,@body))

(verify-macro
	(with-gensym x
		body)

	(let1 x (gensym)
		body))
