(defmacro bind-head-tail (head tail list &rest code)
"BIND-HEAD-TAIL takes a head symbol, a tail symbol, a form that will evaluate
to a list, and a list of forms to evaluate. The forms shall be evaluated with
the head and tail symbols bound to the car and cdr of the value returned by the
list form, respectivly.

(bind-head-tail first rest '(a b c d)
	(values first rest))
=> A
   (B C D)"
	(with-gensym listname
		`(letm* (,listname ,list
		         ,head     (car ,listname)
		         ,tail     (cdr ,listname))
			,@code)))
