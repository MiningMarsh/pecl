(defun integral (f &optional (x 0.0 x-defined-p))
                (declare (type function f)
                         (type float x)
                         (type boolean x-defined-p))
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
