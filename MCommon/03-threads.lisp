(defmacro -> (&rest exprs)
	(bind-head-tail exprs
		(if (not tail)
			head
			(let ((sec (car tail)) (tail (cdr tail)))
				(if (listp sec)
					`(-> (,(car sec) ,head ,@(cdr sec)) ,@tail)
					`(-> (,sec ,head) ,@tail))))))

(defmacro ->> (&rest exprs)
	(bind-head-tail exprs
		(if (not tail)
			head
			(let ((sec (car tail)) (tail (cdr tail)))
				(if (listp sec)
					`(->> (,@sec ,head) ,@tail)
					`(->> (,sec ,head) ,@tail))))))
