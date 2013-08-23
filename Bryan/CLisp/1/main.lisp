#!/usr/bin/sbcl --script
(load "util.lisp")
(defun multiple-3-or-5 (x)
  (or (zerop (rem x 3)) (zerop (rem x 5))))
(princ (reduce #'+ (remove-if-not #'multiple-3-or-5 (range 1 1000))))
