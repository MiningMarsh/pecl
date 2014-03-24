(defun combos (func list1 list2)
	(unnest 
		(mapcar 
			(lambda (x) 
				(mapcar 
					(lambda (y)
						(funcall (the function func) x y))
				list2)) 
		list1)))
