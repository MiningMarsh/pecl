(defun clojure-lambda-symbol-from-string (string)
"Converts a string to a symbol. 
\"A\" -> A"
	(car (with-input-from-string (in string)
		(loop for x = (read in nil nil) while x collect x))))

(defun clojure-lambda-remove-non-symbols (code)
"Remves all values from a list unless they are a symbol.
(\"foo\" bar) -> bar"
	(remove-if-not 
		#'symbolp
		code))

(defun clojure-lambda-symbols-to-strings (code)
"Converts a list of symbols to a list of strings."
	(mapcar #'symbol-name code))

(defun clojure-lambda-remove-non-args (code)
	(remove-if-not 
		(lambda (x)
			(and 
				(equal 
					"%" 
					(subseq x 0 1))
				(numberp
					(clojure-lambda-symbol-from-string
						(subseq x 1)))))
		code))

(defun clojure-lambda-get-arg-numbers (code)
	(mapcar
		(lambda (x) 
			(clojure-lambda-symbol-from-string 
				(subseq x 1)))
		code))

(defun clojure-lambda-flatten (value)
	(if value
		(let ((rest (clojure-lambda-flatten (cdr value)))
		      (first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc (clojure-lambda-flatten first) rest)))
		(list)))

(defun clojure-lambda-arg-count (code)
	(let ((list (clojure-lambda-get-arg-numbers
			(clojure-lambda-remove-non-args
				(clojure-lambda-symbols-to-strings
					(clojure-lambda-remove-non-symbols
						(clojure-lambda-flatten code)))))))
		(if list
			(apply #'max list)
			0)))

(defun clojure-lambda-arg-list (count)
	(labels ((internal (count)
			(if (= count 0)
				nil
				(append 
					(internal (- count 1))
					(list
						(clojure-lambda-symbol-from-string
							(concatenate 'string 
								"%" 
								(write-to-string count))))))))
		(append (internal count) (list '&rest '%&))))

(defun clojure-lambda-replace (map list)
	(if (listp list)
		(mapcar 
			(lambda (x) 
				(clojure-lambda-replace map x))
			list)
		(if map
			(if (equal list (car (car map)))
				(cdr (car map))
				(clojure-lambda-replace (cdr map) list))
		list)))

(defun clojure-lambda-remap-args (list)
	(clojure-lambda-replace '((_ . %1) (% . %1)) list))

(defun clojure-lambda-remap-list (count)
	(labels ((internal (count)
			(if (= count 0)
				nil
				(append 
					(internal (- count 1))
					(list
						(cons
							(clojure-lambda-symbol-from-string
								(concatenate 'string 
									"%" 
									(write-to-string count)))
							(clojure-lambda-symbol-from-string
								(concatenate 'string 
									"%_" 
									(write-to-string count)))))))))
		(append (internal count) (list (cons '%& '%_&)))))

(defun clojure-lambda-handler (stream char)
                              (declare (ignore char))
	(let* ((body (clojure-lambda-remap-args (read-delimited-list #\] stream)))
		  (arg-count (clojure-lambda-arg-count body))
		  (remap (clojure-lambda-remap-list arg-count))
		  (arg-list (clojure-lambda-arg-list arg-count)))
		(clojure-lambda-replace remap 
			`(lambda 
				,arg-list
				,body))))

(set-macro-character #\[ #'clojure-lambda-handler)
(set-macro-character #\] (get-macro-character #\)))
