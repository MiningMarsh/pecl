(defmacro bind-head-tail (list &rest code)
	(let ((listname (gensym)))
		`(let* 
				((,listname ,list)
				(head (car ,listname))
				(tail (cdr ,listname)))
			,@code)))
