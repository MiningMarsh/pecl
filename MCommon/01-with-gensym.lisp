(defmacro with-gensym (var &body body)
	`(let1 ,var ,(gensym)
		,@body))
