(proclaim '(optimize speed))

(labels ((compile-f (file)
		(format t "LOAD ~A~%" (enough-namestring file))
	 	(load (compile-file file :output-file ".build/" :verbose nil :print nil))))
	(mapcar #'compile-f (directory "macros/**/*.lisp")))

(labels ((compile-f (file)
		(format t "COMPILE ~A~%" (enough-namestring file))
	 	(load (compile-file file :output-file ".build/" :verbose nil :print nil))))
	(mapcar #'compile-f (directory "src/**/*.lisp")))

#+clisp (defun compile_entry_point () 
	(time (format t "~A~%" (apply #'main *ARGS*)))
	(exit))

#+sbcl  (defun compile_entry_point () 
	(time (format t "~A~%" (apply #'main (cdr *posix-argv*)))))

(compile 'compile_entry_point)

(format t "BUILD build/out~%")
(finish-output)

#+clisp (saveinitmem 
	"build/out" 
	:init-function 'compile_entry_point
	:executable t 
	:quiet t
	:script nil
	:norc t)

#+sbcl (save-lisp-and-die
	"build/out" 
	:toplevel 'compile_entry_point
	:executable t
	:save-runtime-options t
	:purify t)
