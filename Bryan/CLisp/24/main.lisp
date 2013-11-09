(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defvar *project-description*)
(setq *project-description* "A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?")

(defun flatten-once (xss)
  (apply #'append xss))

(defun permute (xs)
  (if (= (length xs) 1)
	  (list xs)
	  (flatten-once (loop for x in xs collect
						 (loop for ys in (permute (remove x xs)) collect
							  (cons x ys))))))

(defun main ()
  "(nth 999999
   (mapcar
	(lambda (xs) (string-join xs \"\"))
	(permute '(\"0\" \"1\" \"2\" \"3\" \"4\" \"5\" \"6\" \"7\" \"8\" \"9\"))))"
	"This algorithm works, however, it eats a ton of memory, to comare its actual speed
multiply the time you get by running 12 by ten:
2783915460")

