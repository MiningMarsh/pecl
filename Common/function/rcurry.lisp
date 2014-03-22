(defun rcurry (func &rest arguments)
	"Returns function with arguments curried to it. Never calls function."
	(curry func (reverse arguments)))
