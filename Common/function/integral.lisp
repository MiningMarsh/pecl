(defun integral (f &optional (x nil x-defined-p))
	(letm*
			(delta (if (< x 0 ) -0.01 0.01)
			ff
				~(->
					~(->
						(funcall f %2)
						(* delta)
						(+ %1))
					(reduce-range 0 (+ _ delta) :step delta)))
		(if x-defined-p
			(funcall ff x)
			ff)))
