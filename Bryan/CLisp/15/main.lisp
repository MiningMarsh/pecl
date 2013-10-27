(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "Starting in the top left corner of a 2×2 grid, 
and only being able to move to the right and down, there are exactly 
6 routes to the bottom right corner.
How many such routes are there through a 20×20 grid?
")
(defun main ()
  (car (last (crawler 20))))

(defun next-list (lst)
  (labels ((rec (m lst acc)
			 (if (null lst)
				 (nreverse (cons (* 2 m) acc))
				 (let ((nm (+ (car lst) m)))
				   (rec nm (cdr lst) (cons nm acc))))))
	(rec 1 lst nil)))

(defun crawler (n)
  (labels ((rec (m lst)
			 (if (<= m 1)
				 lst
				 (rec (1- m) (next-list lst)))))
	(rec n '(2))))
