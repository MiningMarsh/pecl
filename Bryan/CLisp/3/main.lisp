#!/usr/bin/sbcl --script
(load "util.lisp")
(load "math-util.lisp")
(princ (prime-factors 600851475143))
