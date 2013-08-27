(defmacro while (test &body body)
  `(do ()
	   ((not ,test))
	 ,@body))

(defmacro with-gensyms (syms &body body)
  `(let ,(mapcar #'(lambda (x) `(,x (gensym))) syms)
	 ,@body))


(defmacro collect-list (end-condition next-value var)
  "Generates a list based on the next-value provided."
  (with-gensyms (acc)
	`(let ((,acc nil))
	   (while (not ,end-condition)
		 (push ,var ,acc)
		 (setq ,var ,next-value))
	   (nreverse (cons ,var ,acc)))))

(defmacro -> (expr &rest xs)
  (if (null xs)
	  expr
	  `(-> (,(first xs) ,expr) ,@(rest xs))))

(defmacro => (expr &rest xs)
  (if (null xs)
	  expr
	  (with-gensyms (val)
		`(let ((,val (,(car xs) ,expr)))
		   (if ,val
			   (=> ,val ,@(cdr xs)))))))

(defun cycle-list (xs n)
  (let ((acc nil))
	(map0-n #'(lambda (n) (push (nth n xs) acc)) (1- n))
	(append xs (nreverse acc))))


(defmacro do-tuples/o (params source &body body)
  (with-gensyms (src)
	`(let ((,src ,source))
	   (mapc #'(lambda ,params ,@body) 
			 ,@(map0-n
				#'(lambda (n) `(nthcdr ,n ,src))
				(1- (length params)))
			 nil))))

(defmacro do-tuples/c (params source &body body)
  `(do-tuples/o ,params (cycle-list ,source (1- (length ',params))) ,@body))

(defmacro with-gensym-list (name length &body body)
  (with-gensyms (rec n acc)  
	`(labels ((,rec (,n ,acc)
				(if (zerop ,n)
					(nreverse ,acc)
					(,rec (1- ,n) (cons (gensym) ,acc)))))
	   (let ((,name (,rec ,length nil)))
		 ,@body))))

(defun map0-n (fn n)
  (labels ((rec (x acc)
			 (if (= x n)
				 (nreverse (cons (funcall fn x) acc))
				 (rec (1+ x) (cons (funcall fn x) acc)))))
	(rec 0 nil)))

(defun nil-list-gen (n)
  (map0-n #'(lambda (x) x nil) n))

(defun zip (&rest xs)
  (apply #'mapcar `(list ,@xs)))

(defun unzip (xs)
  (apply #'zip xs))

(defun mostn (fn lst)
  (labels ((rec (lst acc winner)
			 (cond
			   ((null lst)
				(values (reverse acc) winner))
			   ((> (funcall fn (car lst)) winner)
				(rec (cdr lst)
					 (list (car lst))
					 (funcall fn (car lst))))
			   ((= (funcall fn (car lst)) winner)
				(rec (cdr lst)
					 (cons (car lst) acc)
					 (funcall fn (car lst))))
			   (t (rec (cdr lst) acc winner)))))
	(rec lst '() (funcall fn (car lst)))))

(defun rmapcar (fn xss)
  (mapcar #'(lambda (xs)
			  (if (atom xs)
				  (funcall fn xs)
				  (rmapcar fn xs))) xss))

(defun range (x y &optional (step 1))
  "Generates a range with an optional step parameter. It is non-inclusive."
  (if (> (abs (- y (+ step x))) (abs (- y x)))
	  nil
	  (nbutlast (collect-list (= x y) (+ x step) x))))


(defun id (x)  x)

(defun max-in-list (xs)
  (multiple-value-bind (x y) (mostn #'id xs) x y))


(defun fn-ratio (x fn eqc)
  (labels ((rec (y e acc)
			 (if (> y x)
				 (reverse acc)
				 (rec
				  (+ y 1)
				  (if (funcall eqc (funcall fn y))
					  (incf e)
					  e)
				  (cons (float (/ e y))
						acc)))))
	(rec 1 0 nil)))


(defun take (n xs)
  (labels ((rec (n xs acc)
			 (cond ((= n 0) (nreverse acc))
				   ((null xs) nil)
				   (t (rec (1- n) (cdr xs) (cons (car xs) acc))))))
	(rec n xs nil)))

(defun primep (x &optional (p 2))
  (cond ((< x 2) nil)
		((= x 2) t)
		((= 0 (rem x p)) nil)
		((>= p (sqrt x)) t)
		(t (primep x (+ p 1)))))

(defun flatten (xs)
  (apply #'append xs))

(defun relative-path (&rest xs)
  (make-pathname :directory `(:relative ,@xs)))

(defun anyp (fn xs)
  (if (null xs)
	  nil
	  (if (funcall fn (car xs))
		  (car xs)
		  (anyp fn (cdr xs)))))

(defun allp (fn xs)
  (if (null xs)
	  t
	  (if (funcall fn (car xs))
		  (allp fn (cdr xs))
		  nil)))

 (defun string-reduce (fn st &optional (start ""))
   (labels ((rec (st start)
			  (if (string= "" st)
				  start
				  (rec (subseq st 1) (funcall fn start (subseq st 0 1))))))
	 (rec st start)))
