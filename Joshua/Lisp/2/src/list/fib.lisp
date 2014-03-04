(defun fib (iter)
	(iterate #'+ (list 1 1) :while (curry #'> iter)))
