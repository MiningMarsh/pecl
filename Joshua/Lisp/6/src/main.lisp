(defun main (&rest args)
	(format t "~A~%" (car (last (car
		(sort 
			(remove-if-not 
				(lambda (x) 
					(palindromep (digits (car (last x)))))
				(combos #'* 
					(range 100 999) 
					(range 100 999)))
			(lambda (x y) 
				(> 
					(car (last x)) 
					(car (last y))))))))))
