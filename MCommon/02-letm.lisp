(defmacro letm (clauses &body body)
	(labels1 (group-let-statements (list)
			(recursive (acc cur rest)
				(bind-head-tail first rest rest
					(if (not rest)
						acc
						(cond ((

 (letm (x 1
		y 2
		z 3)
	   (print x y z)

=>
(let ((x 1)
	  (y 2)
	  (z 3))

