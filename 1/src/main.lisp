(defun main (&rest args)
	(declare (ignore args))
	(format t "~A~%"
		(sum 
			(remove-if-not
				[reduce 
					[or %1 %2] 
					(mapcar 
						(lambda (x) 
							(= 0 
								(mod _ x))) 
						(list 3 5))]
				(range 1 1000)))))

