(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defvar *project-description*)
(setq *project-description* "
By starting at the top of the triangle below and moving
to adjacent numbers on the row below, the maximum total
from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom in triangle.txt 
(right click and 'Save Link/Target As...'), a 15K text file
containing a triangle with one-hundred rows.

NOTE: This is a much more difficult version of Problem 18.
It is not possible to try every route to solve this problem,
as there are 299 altogether! If you could check one trillion
(10^12) routes every second it would take over twenty billion 
years to check them all. There is an efficient algorithm to solve
it. ;o)")

(defun parse-triangle-string (triangle-string)
  (nreverse
   (rmapcar
	#'parse-integer
	(remove-if (lambda (xs) (string= (car xs) ""))
			   (mapcar
				(lambda (s) (split-string s #\space))
				(split-string triangle-string #\newline))))))

(defun main ()
  (-> "67/triangle.txt"
	  slurp-file
	  parse-triangle-string
	  reduce-triangle))


