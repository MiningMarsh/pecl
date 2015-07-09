(defun prime-factors (number)
"Returns a lit of the prime factors of number. Reducing the resultant list
with multiplication reults in the original number."
	(let ((list (list nil)))
		(recursive (acc acclast cur num) (list list 2 number)
			(if (> cur num)
				(cdr acc)
				(if (= 0 (mod num cur))
					(recur acc (cdr (nconc acclast (list cur))) cur (/ num cur))
				(recur acc acclast (1+ cur) num))))))
