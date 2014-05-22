(defun contains (value list &key (test #'equal))
	(if (not list)
		nil
		(if (funcall test value (car list))
			t
			(contains value (cdr list) :test test))))
