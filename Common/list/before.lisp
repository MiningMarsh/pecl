(defun before (first second list &key (test #'eql))
              (declare (type list list)
                       (type function test))
	(when list
		(bind-head-tail head tail list
			(condm
				(funcall test head second) nil
				(funcall test head first)  list
				                           (before first second tail :test test)))))
