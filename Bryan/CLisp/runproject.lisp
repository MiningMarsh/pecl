(load (compile-file "util.lisp" :verbose nil :print nil))
(load (compile-file "math-util.lisp" :verbose nil :print nil))
(format t "~%")
(defvar *input-command*)
(defvar *inputs*)
(defvar *input*)
(defvar *running-from-runner* t)
(defvar *project-description* "")
(defvar *start-time*)
(setf *input-command* 'yes)  
(setf *inputs*
	  (list '(yes t)
			'(y t)
			'(n nil)
			'(no nil)))
(defun main () 1)
(while (cadr (assoc *input-command* *inputs*))
  (setf *project-description* "")
  (format t "Enter an integer: ")
  (finish-output)
  (setf *input* (read))
  (if (integerp *input*)
	  (progn
		(ensure-directories-exist (relative-path (format nil "~a" *input*)))
		(load (compile-file (concatenate 'string (format nil "~a" *input*) "/" "main.lisp")
							:verbose nil
							:print nil))))
  (format t "~%~%---------------------~%PROJECT DESCRIPTION~%---------------------~%~a~%" *project-description*)
  (format t "---------------------~%RUNNING PROGRAM~%---------------------~%~%")
  (setf *start-time* (get-internal-real-time))
  (main)
  (format t "~%=====================~%")
  (format t "Elapsed time: ~ams~%" (- (get-internal-real-time) *start-time*))
  (format t "=====================~%")
  (format t "~%Would you like to repeat? [y/n] ")
  (setf *input-command* 'herr)
  (while  (not (assoc *input-command* *inputs*))  
	(finish-output)
	(setf *input-command* (read))
	(if (not (assoc *input-command* *inputs*))
		(format t "~%Please enter yes or no ")))
  (format t "~%~%~%"))
(quit)


