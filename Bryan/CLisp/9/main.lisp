(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a² + b² = c²

For example, 3² + 4² = 9 + 16 = 25 = 5².

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
")
(defun is-triple (a b)
  (perfect-squarep (+ (square a) (square b))))



(defun crawler (max)
  (labels ((rec (a b)
			 (declare (integer a) (integer b))
			 (cond 
			   ((is-triple a b)
				(let ((val (+ (ihypot a b) a b)))
				  (cond
					((= val max) (* (ihypot a b) a b))
					((> val max) (rec (1+ a) 1))
					(t (rec a (1+ b))))))
			   ((> (+ a b) max)
				(rec (1+ a) 1))
			   (t
				(rec a (1+ b))))))
	(rec 1 1)))

(defun main ()
  (crawler 1000))





