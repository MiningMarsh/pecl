;;;
;;; A solution to Euler 15 using Lisp.
;;; @author Daniel Vedder
;;; @date 20-21.4.2015
;;;

(defun paths (n &optional (x 0) (y 0))
	"How many paths are there in a n*n grid?"
	(cond ((or (> x n) (> y n) (< x 0) (< y 0)) 'ERROR) ; should never happen
		((and (= x n) (= y n)) 0) ; the end node
		((or (= x n) (= y n)) 1) ; all right and bottom edge nodes have v=1
		;; see explanation.txt for explanation
		((= x y) (if (= (- n x) 1) 2
					 (let ((next (paths n (1+ x) (1+ y))))
						 (* 2 (+ next (* (/ (1- (- n x)) (- n x)) next))))))
		(T (+ (paths n (1+ x) y) (paths n x (1+ y))))))

(defun main (&rest args)
	(declare (ignore args))
	(defvar *n* 20)
	(format t "~&The number of paths in a ~A*~A grid is: ~A"
		*n* *n* (paths *n*)))
