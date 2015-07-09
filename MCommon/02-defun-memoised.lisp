(defmacro defun-memoized (name args &rest body)
	(with-gensyms (table value result found args-f)
		`(let1 ,table (make-hash-table :test 'equal)
			(defun ,name ,args
				(let1 ,args-f (list ,@args)
					(multiple-value-bind (,value ,found) (gethash ,args-f ,table)
						(if ,found
							,value
							(let1 ,result (progn ,@body)
								(setf (gethash ,args-f ,table) ,result)
								,result))))))))
