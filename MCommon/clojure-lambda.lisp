(defpackage "CLOJURE-LAMBDA"
	(:documentation
"Implements the #[] clojure macro syntax as a macro character on [. 
As well, _ becomes synonymous with clojure's %.")
	(:use "COMMON-LISP")
	(:shadow "REPLACE"))

(in-package "CLOJURE-LAMBDA")

(defun remove-non-symbols (code)
"Remves all values from a list unless they are a symbol.
(\"foo\" bar) -> bar"
	(remove-if-not 
		#'symbolp
		code))

(defun symbols-to-strings (code)
"Converts a list of symbols to a list of strings."
	(mapcar #'symbol-name code))

(defun remove-non-args (code)
	(remove-if-not 
		(lambda (x)
			(and 
				(equal 
					"%"
					(subseq x 0 1))
				(numberp
					(read-from-string
						(subseq x 1)))))
		code))

(defun get-arg-numbers (code)
	(mapcar
		(lambda (x) 
			(read-from-string
				(subseq x 1)))
		code))

(defun flatten (value)
	(if value
		(let ((rest (flatten (cdr value)))
		      (first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc (flatten first) rest)))
		(list)))

(defun arg-count (code)
	(let ((list (get-arg-numbers
			(remove-non-args
				(symbols-to-strings
					(remove-non-symbols
						(flatten code)))))))
		(if list
			(apply #'max list)
			0)))

(defun arg-list (count)
	(labels ((internal (count)
			(if (= count 0)
				nil
				(append 
					(internal (- count 1))
					(list
						(read-from-string
							(concatenate 'string 
								"%" 
								(write-to-string count))))))))
		(append (internal count) (list (read-from-string "&rest") (read-from-string "%&")))))

(defun replace (map list)
	(if (listp list)
		(mapcar 
			(lambda (x) 
				(replace map x))
			list)
		(if map
			(if (equal list (car (car map)))
				(cdr (car map))
				(replace (cdr map) list))
		list)))

(defun remap-args (list)
	(replace 
		(list
			(cons (read-from-string "_") (read-from-string "%1")) 
			(cons (read-from-string "%") (read-from-string "%1"))) 
		list))

(defun remap-list (count)
	(labels ((internal (count)
			(if (= count 0)
				nil
				(append 
					(internal (- count 1))
					(list
						(cons
							(read-from-string
								(concatenate 'string 
									"%" 
									(write-to-string count)))
							(read-from-string
								(concatenate 'string 
									"%_" 
									(write-to-string count)))))))))
		(append (internal count) (list (cons (read-from-string "%&") (read-from-string "%_&"))))))

(defun handler (stream char)
                              (declare (ignore char))
	(let* ((body (remap-args (read-delimited-list #\] stream)))
		  (arg-count (arg-count body))
		  (remap (remap-list arg-count))
		  (arg-list (arg-list arg-count)))
		(replace remap 
			`(lambda 
				,arg-list
				,body))))

(set-macro-character #\[ #'handler)
(set-macro-character #\] (get-macro-character #\)))
