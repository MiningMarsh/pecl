(defun range (start end)
	(let ((start (if (< start end) start end))
	      (end  (if (< start end) end start)))
		(loop for i from start below end collect i)))
