(defun curry (func &rest args)
             (declare (type function func)
                      (type list args))
"Returns function with arguments curried to it. Never calls function."
		~(apply func (append args (the list %&))))
