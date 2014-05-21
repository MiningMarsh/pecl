(defun range (start &optional (end nil end-provided-p) (step nil step-provided-p))
"Returns a range from start to end using start. If no end is specified,
start is ued as end, and (* (sign start) 1) is used as start."
	(if (not end-provided-p)
		(if (> start 0)
			(range 1 start)
			(range -1 start))
		(labels
				((reduction (acc n) (cons n acc)))
			(reverse 
				(if step-provided-p
					(reduce-range (the function #'reduction) start end :step step :initial-value nil)
					(reduce-range (the function #'reduction) start end :initial-value nil))))))
