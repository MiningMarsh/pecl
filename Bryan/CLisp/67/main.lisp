(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(setq *project-description* "")
(defun parse-triangle-string (triangle-string)
  (rmapcar
   #'parse-integer
   (mapcar
	(lambda (s) (split-string s #\space))
	(split-string triangle-string #\newline))))
(defun main ()
  )
