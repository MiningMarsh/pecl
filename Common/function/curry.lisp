(defun curry (func &rest args)
"Returns function with arguments curried to it. Never calls function."
		[apply (the function func) (append args %&)])
