(defmacro -> (&rest exprs)
	(bind-head-tail first rest exprs
		(if (not rest)
			first
			(bind-head-tail second rest rest
				(if (listp second)
					`(-> (,(car second) ,first ,@(cdr second)) ,@rest)
					`(-> (,second ,first) ,@rest))))))

(defmacro ->> (&rest exprs)
	(bind-head-tail first rest exprs
		(if (not rest)
			first
			(bind-head-tail second rest rest
				(if (listp second)
					`(->> (,@second ,first) ,@rest)
					`(->> (,second ,first) ,@rest))))))
