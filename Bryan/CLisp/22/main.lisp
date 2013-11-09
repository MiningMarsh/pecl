(if (not (boundp '*running-from-runner*))
	(load (compile-file "math-util.lisp")))
(defvar *project-description*)
(setq *project-description* "Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.

What is the total of all the name scores in the file?")

(defun get-sorted-names ()
  (sort
   (eval (read-from-string
		  (concatenate
		   'string
		   "(list"
		   (string-join
			(split-string (slurp-file "22/names.txt") #\,)
			" ")
		   ")")))
   #'string<))

(defun calculate-name-score (name)
  (apply #'+ (map 'list (lambda (c) (1+ (- (char-code c) (char-code #\A))))
				  name)))

(defun zip-with-indicies (xs)
  (zip xs (range 1 (1+ (length xs)))))

(defun calculate-name-scores (names)
  (mapcar #'calculate-name-score names))

(defun main ()
  (sum (mapcar #'product (zip-with-indicies (calculate-name-scores (get-sorted-names))))))
