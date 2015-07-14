(defun compose (&rest funcs)
"Returns the composition of the passed functions. Resulting function
takes the same arguments as the topmost function."
	(bind-head-tail func rest funcs
		(if rest
			~(apply func (->
				(the function #'compose)
				(apply rest)
				(apply %&)
				multiple-value-list))
			~(apply func %&))))
