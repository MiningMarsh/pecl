(defun compose (&rest funcs)
               (declare (type list funcs))
"Returns the composition of the passed functions. Resulting function
takes the same arguments as the topmost function."
	(bind-head-tail func rest funcs
		(if rest
			~(apply (the function func) (->
				(the function #'compose)
				(apply rest)
				(apply %&)
				multiple-value-list))
			~(apply (the function func) %&))))
