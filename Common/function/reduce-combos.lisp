(defun reduce-combos (fn initial-value &rest lists)
	(if (reduce (lambda (%1 %2) (or %1 %2)) (print (mapcar (lambda (_) (equal _ nil)) lists)))
		initial-value
		0))

(print (reduce-combos (lambda (_) (+ _ _)) 5 nil '(1 2 3)))
(print (reduce-combos (lambda (_) (+ _ _)) 5 '(1 2 3) '(1 2 3)))
