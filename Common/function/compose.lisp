(defun compose (&rest funcs)
"Returns the composition of the passed functions. Resulting function
takes the same arguments as the topmost function."
	(let 
			((func (car funcs))
			(rest (cdr funcs)))
		(if rest
				[->> 
					(-> 
						(the function #'compose) 
						(apply rest) 
						(apply %&)) 
					(funcall func)]
			[apply func %&])))
