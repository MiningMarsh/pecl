(defun iterator-from-combos (&rest lists)
"Takes a set of lists, and returns an iterator that iterates through every
possible combo of values where each value is from the list passed at its
index."
	; If any of the passed lists are nil, no combos can be made.
	(if (member nil lists)
		; There are no combos, return an empty iterator.
		(lambda () (values nil t))
		; Otherwise, build the combos iterator.
		(labels
				; Shifts the set of lists down by one. Returns two values, the new
				; lists, and whether we have hit the end.
				((shift (lists base)
					; If no lists have been passed, we are done shifting.
					(if (not lists)
						; Return done value.
						(values nil t)
						(let ((first (car lists)) (rest (cdr lists)))
							; Test if we need to ripple shift.
							(if (not (cdr first))
								; Ripple
								(multiple-value-bind (result done) (shift (cdr lists) (cdr base))
									(values (cons (car base) result) done))
								; Otherwise, shift one and return.
								(values (cons (cdr first) rest) nil))))))
			; State variables.
			(let ((state lists))
				; The actual iterator.
				(lambda ()
					; Check if last iteration.
					(if (not state)
						; Stop signal
						(values nil t)
						; Temporary storage of this result.
						(let ((result (mapcar #'car state)))
							; Shift.
							(multiple-value-bind (new done) (shift state lists)
								; The shift function says we are done, set up so next iterations is last iteration.
								(if done
									(setf state nil)
									(setf state new))
								(values result nil)))))))))
