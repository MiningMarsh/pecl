(defun repeat (func times data)
	(if (< times 1)
		data
		(repeat func (1- times) (funcall (the function func) data))))
