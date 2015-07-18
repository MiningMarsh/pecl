(defun digits (num)
"Return a list of the digits that make up num."
	(->>
		num
		(collect
			~(mod _ 10)
			~(floor (/ _ 10))
			~(= 0 _))
		nreverse))
