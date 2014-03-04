(defun iterate (lvalue ivalues &key 
                (until nil until-provided-p) 
                (while nil while-provided-p)
				(times nil times-provided-p))
	(labels ((internal (acc acclast values iter)
		(let ((value (apply (the function lvalue) values)))
			(if (if (or while-provided-p until-provided-p times-provided-p)
					(and
						(if while-provided-p
							(funcall (the function while) value)
							t)
						(if until-provided-p
							(not (funcall (the function until) value))
							t)
						(if times-provided-p
							(< iter times)
							t))
					value)
				(internal 
					acc
					(cdr (nconc acclast (list value)))
					(nconc (cdr values) (list value))
					(1+ iter))
				(cdr acc)))))
		(let ((acc (list nil)))
			(internal acc (nlast 1 acc) (car (list ivalues)) 0))))
