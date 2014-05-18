(defun range (start end &optional (step nil step-provided-p))
	(labels
			((reduction (acc n) (cons n acc)))
		(reverse 
			(if step-provided-p
				(reduce-range (the function #'reduction) start end :step step :initial-value nil)
				(reduce-range (the function #'reduction) start end :initial-value nil)))))
