#!/usr/bin/sbcl --noprint --script
(load "util.lisp")
(format t "Enter an integer: ")
(finish-output)
(defvar *input* (read))
(defvar *project-description* "")
(if (integerp *input*)
	(progn
	  (ensure-directories-exist (relative-path (format nil "~a" *input*)))
	  (load (compile-file (concatenate 'string (format nil "~a" *input*) "/" "main.lisp") :verbose nil))))
(format t "~%~%---------------------~%PROJECT DESCRIPTION~%---------------------~%~a~%" *project-description*)
(format t "---------------------~%RUNNING PROGRAM~%---------------------~%~%")
(defvar *start-time* (get-internal-real-time))
(main)
(format t "~%=====================~%")
(format t "Elapsed time: ~ams~%" (- (get-internal-real-time) *start-time*))
(format t "=====================~%")
(quit)

