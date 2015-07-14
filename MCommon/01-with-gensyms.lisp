(defmacro with-gensyms ((sym &rest syms) &body body)
"WITH-GENSYMS takes a list of symbols, and evaluates the following forms
with every symbol from the list bound to a gensym."
	(let1 syms (cons sym syms)
		`(let ,(mapcar (lambda (n) `(,n (gensym))) syms)
			,@body)))

(verify-macro
	(with-gensyms (s1 s2 s3)
		body)

	(let ((s1 (gensym))
	      (s2 (gensym))
	      (s3 (gensym)))
		body))
