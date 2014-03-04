(defun iterate (lvalue ivalues &key 
                (until #'identity until-provided-p) 
                (while #'identity while-provided-p)
				(last-value nil)
				(times 0 times-provided-p))
                (declare (type function lvalue)
						 (type list ivalues)
						 (type function until)
						 (type function while)
						 (type fixnum times))
"Iterate compiles a list or a value from taking a function and executing
it continually in the fibonnaci style."
	(labels ((internal (acc acclast iter)
	                   (declare (type list acc)
	                            (type list acclast)
	                            (type fixnum iter))
		(let ((value (apply lvalue acclast)))
			(if (if (or 
						while-provided-p 
						until-provided-p 
						times-provided-p)
					(and
						(if while-provided-p
							(funcall while value)
							t)
						(if until-provided-p
							(not (funcall until value))
							t)
						(if times-provided-p
							(< iter times)
							t))
					value)
				(internal 
					(if last-value (cdr acc) acc)
					(cdr (nconc acclast (list value)))
					(1+ iter))
				(if last-value (car (nlast acclast)) (cdr acc))))))
		(let ((acc (copy-list ivalues)))
			(internal 
				acc
				acc
				0))))
