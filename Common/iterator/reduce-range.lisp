(defun reduce-range (fn start end &key (s 1) (initial-value nil initial-value-provided-p))
	(macrolet
			((loop-range (stepper direction)
				`(loop
					for i
					from (if initial-value-provided-p start (,stepper start s))
					,direction end
					by s
					do (setq acc (funcall fn acc i)))))
		(let ((direction (if (< start end) t nil))
		      (acc (if initial-value-provided-p start)))
			(if direction
				(loop-range + to)
				(loop-range - downto))
			acc)))

