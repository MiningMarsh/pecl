#!/usr/bin/sbcl --script
(load "math-util.lisp")
"
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.
"
(defun palindrome-number (x)
  (let ((str (format nil "~a" x)))
	(string= str (reverse str))))
(defun crawler ()
  (flatten (mapcar (lambda (x) (mapcar (lambda (y) (* x y)) (range 999 (1- x) -1))) (range 999 99 -1))))
(princ (car (sort (remove-if-not #'palindrome-number (crawler)) #'>)))
