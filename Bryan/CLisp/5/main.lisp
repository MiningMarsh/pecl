(if (not (boundp *running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defun main ()
  "
2520 is the smallest number that can be divided by each of the numbers from 1 to 
10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the 
numbers from 1 to 20?

SOLVED mathematically with pen and paper in under a minute

Solution obtained by prime-factorizing all numbers from one to twenty, then 
taking the maximum number of repetions of each prime factor then multiplying

EX  for 1-8:
 2: 2
 3: 3
 4: 2 2
 5: 5
 6: 2 3
 7: 7
 8: 2 2 2

  8     3   5   7
2*2*2 * 3 * 5 * 7 = 840

For 1-20:  232792560
")
