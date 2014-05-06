(defun main (&rest args)
            (declare (ignore args))
	(format t "~A~%"
		(car 
			(print
				(remove-if-not #'palindromep
					(mapcar #'digits 
						(combos 
							[* %1 %2] 
							(range 100 999) 
							(range 100 999))))))))
