(require 'sb-bsd-sockets)
(load (compile-file "util.lisp" :verbose nil :print nil))
(load (compile-file "math-util.lisp" :verbose nil :print nil))
(format t "~%")
(defvar *input-command*)
(defvar *inputs*)
(defvar *input*)
(defvar *running-from-runner* t)
(defvar *project-description* "")
(defvar *start-time*)
(defvar *end-time*)
(defvar *result*)
(defvar *valid-string*)

(defun pretty-problem-join (xs)
  (let ((probs (remove-if-not #'car (section-encode xs))))
	(string-join (mapcar
				  (lambda (section)
					(var-bind (start-ind end-ind) (cdr section)
					  (if (zerop (- end-ind start-ind))
						  (format nil "~a" start-ind)
						  (format nil "~a-~a" start-ind end-ind))))
				  probs)
				 ",")))

(defun get-valid-problems ()
  (map0-n
   (lambda (n) (file-exists (format nil "~a/main.lisp" n)))
   600))


(setf *inputs*
	  (list '(yes t)
			'(y t)
			'(n nil)
			'(no nil)))



(defun main-loop (&optional (argv nil))
  (setf *valid-string* (pretty-problem-join (get-valid-problems)))
  (format t "Welcome to the project euler project manager!~%")
  (setf *input-command* 'yes)
  (while (cadr (assoc *input-command* *inputs*))
	(setf *project-description* "")
	(if (null argv)
		(progn
		  (format t "Valid selections: ~a: " *valid-string*)
		  (finish-output)
		  (setf *input* (read)))
		(progn
		  (setf *input* (read-from-string (car argv)))
		  (setf argv (cdr argv))))
	(if (integerp *input*)
		(progn
		  (handler-case
			  (progn
				(load (compile-file (concatenate 'string (format nil "~a" *input*) "/" "main.lisp")
									:verbose nil
									:print nil))
				(let ((-sep (string-multiply "-" 32)) (=sep (string-multiply "=" 32)))
				  (format t "~%~%~a~%PROJECT DESCRIPTION~%~a~%~a~%" -sep -sep  *project-description*)
				  (format t "~a~%RUNNING PROGRAM~%~a~%~%" -sep -sep)
				  (setf *start-time* (get-microseconds-of-day))
				  (setf *result* (main))
				  (setf *end-time* (get-microseconds-of-day))
				  (format t "~a~%~%~a~%" *result* =sep)
				  (format t "Elapsed time: ~a ms~%" (/ (- *end-time* *start-time*) (expt 10.0 3)))
				  (format t "~a~%" =sep)))
			(file-error (e) (format t "~a"
									"That project doesn't exist.")))
		  (format t "~%Would you like to repeat? [y/n] ")
		  (setf *input-command* (get-valid-input-from-list
								 *inputs*
								 "Please select yes or no"))
		  (format t "~%~%~%"))))
  (quit))

