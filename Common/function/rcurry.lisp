(defun rcurry (func &rest args)
"Returns function with arguments curried to the end of it. Never calls 
function."
	[apply (the function func) (append %& args)])
