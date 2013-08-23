#!/usr/bin/sbcl --script
(load "util.lisp")
(format t "Enter an integer: ")
(finish-output)
(defvar *input* (read))
(if (integerp *input*)
	(progn
	  (ensure-directories-exist (relative-path (format nil "~a" *input*)))
	  (run-program "/bin/ln" `("-s" "../util.lisp" ,(format nil "~a/util.lisp" *input*)))
	  (run-program "/bin/ln" `("-s" "../math-util.lisp" ,(format nil "~a/math-util.lisp" *input*)))
	  (run-program "/bin/cp" `("example-main.lisp" ,(format nil "~a/main.lisp" *input*))))
	(error "GAAAAAHHHH NOT AN INTEGER!!!!"))
