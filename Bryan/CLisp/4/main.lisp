(if (not (boundp *running-from-runner*))(load (compile-file "math-util.lisp")))
"
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.
"
(defun palindrome-number (x)
  (let ((str (write-to-string x)))
	(string= str (reverse str))))
(defun crawler (max-num)
  (labels ((rec (i j upb mp) 
         (let ((pr (* i j)))
           (cond
         ((<= i upb) mp) 
         ((< pr mp) (rec (1- i) max-num upb mp))
         ((palindrome-number pr) (rec (1- i) max-num (sqrt pr) pr))
         ((<= j upb) (rec (1- i) max-num upb mp))
         (t (rec i (1- j) upb mp))))))
    (rec max-num max-num 1 1)))
(defun main ()
(format t "~a~%" (crawler 999))
)
