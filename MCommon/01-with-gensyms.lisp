(defmacro with-gensyms ((sym &rest syms) &body body)
	(let1 syms (cons sym syms)
		`(let ,(mapcar (lambda (n) `(,n (gensym))) syms)
			,@body)))
