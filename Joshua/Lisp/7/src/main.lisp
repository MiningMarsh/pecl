(primep 3)
(primep 4)

(defun main (&rest args)
	(if args
		(format t "~A~%" 
				(remove-if-not 
					#'primep
					(print (range 3 20)))))
	0)
