(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.
")

(defun palindrome-number (x &optional (sz (log x 10)))
  (labels
	  ((rec ( base1 base2)
		 (cond
		   ((>= base2 base1) t)
		   ((not
			 (= (mod (truncate x base1) 10) (mod (truncate x base2) 10)))
			nil)
		   (t
			(rec (/ base1 10) (* base2 10))))))
	(rec  (expt 10 (truncate sz)) 1)))


(defun crawler (max-num)
  (let ((sz (log (square max-num) 10)))
	(labels ((rec (i j upb mp) 
			   (let ((pr (* i j)))
				 (cond
				   ((<= i upb) mp) 
				   ((< pr mp) (rec (1- i) max-num upb mp))
				   ((palindrome-number pr sz) (rec (1- i) max-num (sqrt pr) pr))
				   ((<= j upb) (rec (1- i) max-num upb mp))
				   (t (rec i (1- j) upb mp))))))
	  (rec max-num max-num 1 1))))

(defun main ()
  (crawler 999))

