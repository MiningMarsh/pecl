
(defun range (start end)
	(let ((start (if (< start end) start end))
	      (end  (if (< start end) end start)))
		(loop for i from start below end collect i)))
(defun primep (num)
	(reduce 
		(lambda (x y) 
			(and x y)) 
		(mapcar 
			(lambda (z) (= 0 (mod num z)))
			(range 2 (1- num)))))

(print (remove-if-not #'primep '(3 4 5 6 7 8 9 10)))
