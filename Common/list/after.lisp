(defun after (first second list &key (test #'eql))
	(when-bind tail (before second first list :test test)
		(member first tail :test test)))
