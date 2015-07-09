(print (macroexpand '(defmacro bind-head-tail (head tail list &rest code)
	(with-gensym listname
		`(let*
				((,listname ,list)
				(,head (car ,listname))
				(,tail (cdr ,listname)))
			,@code)))))
