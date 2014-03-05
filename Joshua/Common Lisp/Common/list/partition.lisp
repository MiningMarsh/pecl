(defun partition (size list)
	"Splits a list into sized chunks."
	(labels ((internal (accumulator)
			(if list
				(multiple-value-bind (head tail) (split size list)
				(partition tail (append accumulator (list head))))
			accumulator)))
		(internal (list))))
