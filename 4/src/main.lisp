(defun main (&rest args)
            (declare (ignore args))
	(reduce-iterator
		; Lambda that returns the max of two combos.
		~(let ((value (apply #'* %2)))
			; Make sure the combo is a palindrome.
			(if (-> value digits palindromep)
				; If so, return it if it is larger than last palindrome.
				(if (> value %1)
					value
					%1)
				%1))
		; Returns an interator of combos from every 2 possible 3 digit numbers.
		(let ((range (range 100 999)))
			(iterator-from-combos range range))
		; Bootstrap accumulator.
		:initial-value 0))
