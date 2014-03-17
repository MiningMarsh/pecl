(defun compose (&rest funcs)
	(let ((func (car funcs))
	      (rest (cdr funcs)))
	(if rest
		(let ((composed (apply (the function #'compose) rest)))
			(lambda (&rest args)
				(funcall
					(the function func) 
					(car (funcall 
						(the function composed) 
						args)))))
		(lambda (&rest args) 
			(apply 
				(the function func)
				args)))))
