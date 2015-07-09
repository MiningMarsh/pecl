(defmacro bind-head-tail (list &rest code)
	(with-gensyms (listname)
		`(let*
				((,listname ,list)
				(head (car ,listname))
				(tail (cdr ,listname)))
			,@code)))
