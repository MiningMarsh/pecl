#!/usr/bin/sbcl --script
(load "util.lisp")
(format t "Enter an integer: ")
(finish-output)
(defvar *input* (read))
(if (integerp *input*)
	(progn
	  (ensure-directories-exist (relative-path (format nil "~a" *input*)))
	  (load (compile-file (concatenate 'string (format nil "~a" *input*) "/" "main.lisp")))))
