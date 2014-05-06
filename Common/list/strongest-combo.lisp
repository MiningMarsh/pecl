(defun combos (func &rest lists)
	(labels ((internal (lists)
			(let ((first (car lists))
			      (rest (cdr lists)))
				(mapcar
					(lambda (x)
						(cons x)
		(internal lists)))

(print (combos #'identity '(1 2 3 4) '(10 20 30 40) '(100 200 300 400)))
