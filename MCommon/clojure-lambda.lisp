(defpackage "CLOJURE-LAMBDA"
	(:documentation
"Implements the #[] clojure macro syntax as a macro character on [. 
As well, _ becomes synonymous with clojure's %.")
	(:use "COMMON-LISP")
	(:shadow "REPLACE"))

(in-package "CLOJURE-LAMBDA")

(defun remove-non-symbols (code)
"Removes all values from a list unless they are a symbol.
(5 bar) -> bar"
	(remove-if-not 
		#'symbolp
		code))

(defun symbols-to-strings (code)
"Converts a list of symbols to a list of strings.
(1 2 3) -> (''1'' ''2'' ''3'')"
	(mapcar #'symbol-name code))

(defun remove-non-args (code)
"Removes all symbols from a list that are not of the format '%' followed by a
number.
(''%1'' ''%2'' ''asd'' ''5'') -> (%1 %2)"
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
"Extracts argument numbers from a properly formatted list of argument symbols.
(''%1'' ''%2'' ''%3'') -> (1 2 3)"
	(mapcar
		(lambda (x) 
			(read-from-string
				(subseq x 1)))
		code))

(defun flatten (value)
"Flattens a list.
((1 2 3 (4 5) 6) 7 8) -> (1 2 3 4 5 6 7 8)"
	(if value
		(let ((rest (flatten (cdr value)))
		      (first (car value)))
			(if (atom first)
				(cons first rest)
				(nconc (flatten first) rest)))
		(list)))

(defun arg-count (code)
"Returns the largest argument out of a list of arguments.
(%6 %1) -> 6"
	(let ((list (get-arg-numbers
			(remove-non-args
				(symbols-to-strings
					(remove-non-symbols
						(flatten code)))))))
		(if list
			(apply #'max list)
			0)))

(defun arg-list (count)
"Generate an argument list from a given count of arguments.
6 -> (%1 %2 %3 %4 %5 %6 &rest %&)"
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
"Replace symbols in a list using an assoc-list map.
((3 . 4) (1 . 2)) (3 2 1) -> (4 2 2)"
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
"Remaps _ and % in a body of code to %1.
(+ _ 1) -> (+ %1 1)"
	(replace 
		(list
			(cons (read-from-string "_") (read-from-string "%1")) 
			(cons (read-from-string "%") (read-from-string "%1"))) 
		list))

(defun remap-list (count)
"Generates a remapping list for use with replace that replaces symbols of the 
form '%' and a number with '%_' and a number.
2 -> ((%1 . %_1) (%2 . %_2) (%& . %_&))"
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
"Converts a clojure-lambda form into a lambda form.
[+ _ 1] -> (lambda (%_1 &rest %_&) (+ %_1 1))"
	(let* ((body (remap-args (read-delimited-list #\] stream)))
		  (arg-count (arg-count body))
		  (remap (remap-list arg-count))
		  (arg-list (arg-list arg-count)))
		(replace remap 
			`(lambda 
				,arg-list
				,body))))

; Define the macro character.
(set-macro-character #\[ #'handler)
(set-macro-character #\] (get-macro-character #\)))
