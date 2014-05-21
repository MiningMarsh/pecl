(defun iterator-from-range (start &optional (end nil end-provided-p) (step nil step-provided-p))
	(let
			((start
				(if end-provided-p
					start 
					(if (< 0 start) 1 -1)))
			(end
				(if end-provided-p
					end
					start)))
		(let 
				((step
					(*
						(if (< start end) 1 -1)
						(if step-provided-p
							(abs step)
							1))))
			(let ((i start))
				(lambda () 
					(if
						(if (< start end)
							(>= i end)
							(<= i end))
						(values nil t)
						(let ((value i))
							(setf i (+ i step))
							(values value nil))))))))
