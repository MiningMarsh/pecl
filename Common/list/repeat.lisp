(defun repeat (times value)
	(labels ((internal (times value acc)
			(if (= times 0)
				acc
				(internal (1- times) value (cons value acc)))))
		(internal times value nil)))
