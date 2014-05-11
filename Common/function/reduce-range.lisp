(defun reduce-range (fn start end &key (initial-value nil initial-value-provided-p) (step nil step-provided-p))
	(let*
			((stepi
				(if step-provided-p
					step
					(if (> end start) 1 -1)))
			(initial
				(if initial-value-provided-p
					initial-value
					start))
			(next 
				(if initial-value-provided-p
					start
					(+ initial stepi))))
		(labels
				((test (n) 
					(or 
						(and 
							(>= stepi 0) 
							(>= n end)) 
						(and 
							(< stepi 0) 
							(<= n end))))
				(internal (acc n)
					(if (test n)
						acc
						(internal (funcall fn acc n) (+ n stepi)))))
			(if (test next)
				initial
				(internal initial next)))))
