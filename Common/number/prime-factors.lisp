(defun prime-factors (number)
"Returns a lit of the prime factors of number. Reducing the resultant list 
with multiplication reults in the original number."
	(labels 
			((internal (acc acclast cur num)
				(if (> cur num)
					(cdr acc)
					(if (= 0 (mod num cur))
						(internal acc (cdr (nconc acclast (list cur))) cur (/ num cur))
					(internal acc acclast (1+ cur) num)))))
		(let ((list (list nil)))
			(internal list list 2 number))))
