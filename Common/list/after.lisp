(defun after (first second list &key (test #'equal))
	(when-bind tail (before second first :test test)
		(member first tail :test test)))
