(defun curry (func &rest arguments)
	"Returns function with arguments curried to it. Never calls function."
	(lambda (&rest args2)
		(apply (the function func) (append arguments args2))))
