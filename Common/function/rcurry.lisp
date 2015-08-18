(defun rcurry (func &rest args)
              (declare (type function func)
                       (type list args))
"Returns function with arguments curried to the end of it. Never calls
function."
	~(apply func (append (the list %&) args)))
