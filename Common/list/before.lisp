(defun before (first second list &key (test #'equal))
	(when list
		(bind-head-tail head tail list
			(condm
				(funcall test head second) nil
				(funcall test head first)  list
				                           (before first second tail :test test)))))

