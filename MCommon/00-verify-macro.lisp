;; I don't really want to pollute the global namespace with a comparison
;; function used just for this, but I probably should. Then again, after
;; the commpiliation stage, this is technically more efficient that
;; leaving a function lying around.
(defmacro verify-macro-with-gensyms (gensyms original expansion)
"Takes a list of symbols as its first argument, a macro form as its second
argument, and the expected expansion of that macro form as its third argument.
It checks that the expansion is identical to the expanded macro form. Each
symbol from the symbol list that is encountered is ensured to have identical
values, to allow one to check macros that include gensyms."
	`(let ((set (make-hash-table))
	      (table (make-hash-table :test #'equal)))
		(mapc (lambda (sym) (setf (gethash sym set) t)) ',gensyms)
		(labels ((compare (src target)
				(cond
					((consp src)
						(when (consp target)
							(and
								(compare (car src) (car target))
								(compare (cdr src) (cdr target)))))
					((gethash src set)
						(let ((result (gethash src table)))
							(if result
								(equal result target)
								(progn (setf (gethash src table) target) t))))
					(t (equal src target)))))
			(when (not (compare ',expansion (macroexpand-1 ',original)))
			  (error "Macro implemented incorrectly.")))))

(defmacro verify-macro (original expansion)
"Shorthand way of calling VERIFY-MACRO-WITH-GENSYMS with an empty symbol list."
	`(verify-macro-with-gensyms () ,original ,expansion))

(defmacro verify-macro-with-gensym (gensym original expansion)
"Shorthand way of calling VERIFY-MACRO-WITH-GENSYMS with a single symbol in its
symbol list."
	`(verify-macro-with-gensyms (,gensym) ,original ,expansion))
