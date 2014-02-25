(defun main (&rest args)
	(format t "~A~%"
		(sum 
			(remove-if-not
				(lambda (x)
					(or
						(= (mod x 3) 0)
						(= (mod x 5) 0)))
				(range 1 1000)))))

