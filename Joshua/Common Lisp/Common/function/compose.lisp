(defun compose (&rest funcs)
	(let ((func (car funcs))
	      (rest (cdr funcs)))
	(if rest
		(let ((composed (apply (the function #'compose) rest)))
			[funcall funcfunc (car (funcall composed %&))])
		[apply func %&])))
