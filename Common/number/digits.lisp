(defun digits (num)
"Return a list of the digits that make up num."
	(labels ((internal (acc num)
		(if (= 0 num)
			acc
			(internal (cons (mod num 10) acc) (floor (/ num 10))))))
	(internal (list) num)))
