(defun nlast (length list)
	"Returns the last n alues of list. Modifying the resulting list modifies the original."
	(do ((list list (cdr list))
	     (i (- (length list) length) (- i 1)))
		((< i 1) list)))
