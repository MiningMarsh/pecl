(defun digits (num)
"Return a list of the digits that make up num."
	(recursive (acc num) ((list) num)
		(if (= 0 num)
			acc
			(recurse (cons (mod num 10) acc) (floor (/ num 10))))))
