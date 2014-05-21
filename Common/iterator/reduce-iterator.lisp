(defun reduce-iterator (fn iterator &key (initial-value nil initial-value-provided-p))
	(multiple-value-bind (next done) (funcall iterator)
		(if done
			initial-value
			(if initial-value-provided-p
				(reduce-iterator 
					fn 
					iterator
					:initial-value (funcall fn initial-value next))
				(reduce-iterator fn iterator :initial-value next)))))
