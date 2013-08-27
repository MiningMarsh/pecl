(load (compile-file "math-util.lisp"))
(princ (reduce #'+ (remove-if-not (lambda (x) (and (evenp x) (< x 4000000))) (fib-list 100)))) 
