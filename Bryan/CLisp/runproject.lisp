(require 'sb-bsd-sockets)
(load (compile-file "util.lisp" :verbose nil :print nil))
(load (compile-file "math-util.lisp" :verbose nil :print nil))
(load (compile-file "runload.lisp" :verbose nil :print nil))
(main-loop sb-ext:*posix-argv*)

