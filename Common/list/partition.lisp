(defun partition (size list)
"Splits a list into sized chunks."
	(labels 
			((internal (length lists)
				(multiple-value-bind (head tail) (split (car lists) size)
					(if (not tail)
						(values (nreverse lists) length)
						(internal 
							(1+ length) 
							(cons tail (cons head (cdr lists))))))))
		(internal 0 (list list))))
