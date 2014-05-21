(defun repeat (n value)
"Returns a list of a value repeated n times."
	(labels 
			((internal (times acc)
				(if (= times 0)
					acc
					(internal (1- times) (cons value acc)))))
		(internal n nil)))
