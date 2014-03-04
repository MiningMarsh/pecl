(defun split (at list) 
	"Returns the list split at the specified point."
	(do* ((length 0 (1+ length))
		  (head (list) (append head (list (car tail))))
	      (tail list (cdr tail)))
		((or (not tail) (= length at)) (values head tail))))
