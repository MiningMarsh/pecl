(defun reduce-range (fn start end &key (step 1) (initial-value nil initial-value-provided-p))
	(let ((iterator (iterator-from-range start end step)))
		(if initial-value-provided-p
			(reduce-iterator fn iterator :initial-value initial-value)
			(reduce-iterator fn iterator))))
