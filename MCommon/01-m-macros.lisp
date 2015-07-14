(labels
		((group-two-internal (acc cur rest)
			(if (not rest)
				(nreverse acc)
				(if (not cur)
					(group-two-internal acc (car rest) (cdr rest))
					(group-two-internal (cons (list cur (car rest)) acc) nil (cdr rest)))))
		(group-two (list) (group-two-internal nil nil list)))
	(defmacro letm (binds &body body)
		`(let ,(group-two binds)
			,@body))
	(defmacro letm* (binds &body body)
		`(let* ,(group-two binds)
			,@body))
	(defmacro condm (&body conditions)
		`(cond ,@(group-two conditions))))
(verify-macro
	(letm (x 1
	       y 2
	       z 3)
		(print x y z))

	(let ((x 1)
	      (y 2)
	      (z 3))
		(print x y z)))

(verify-macro
	(letm* (x 1
	        y 2
	        z 3)
		(print x y z))

	(let* ((x 1)
	       (y 2)
	       (z 3))
		(print x y z)))

(verify-macro
	(condm
		(= x 1) t
		t       nil)

	(cond
		((= x 1) t)
		(t nil)))
