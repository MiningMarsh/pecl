(require 'sb-bsd-sockets)
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
  (cond 
	((null xs)
	 expr)
	((listp (first xs))
	  `(-> (,(first (first xs)) ,@(cdr (first xs)) ,expr) ,@(rest xs)))
	(t
	   `(-> (,(first xs) ,expr) ,@(rest xs)))))

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
  `(do-tuples/o ,params (cycle-list
						 ,source (1- (length ',params))) ,@body))

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

(defmacro var-bind (params values &body body)
  `(apply (lambda ,params ,@body) ,values))

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
				 (rec (subseq st 1)
					  (funcall fn start (subseq st 0 1))))))
	(rec st start)))

(defun n-mth (n m mat)
  (nth n
	   (nth m mat)))

(defun ns-lookup (hostname)
  (sb-bsd-sockets:host-ent-address
   (sb-bsd-sockets:get-host-by-name hostname)))

(defun array-nmth (arr n m)
  (var-bind (mn mm) (array-dimensions arr)
	(if (or
		 (>= n mn) (< n 0)
		 (>= m mm) (< m 0))
		(values nil nil)
		(values (aref arr n m) t))))
(defun tcp-connect (hostname port)
  (let ((socket (make-instance 'sb-bsd-sockets:inet-socket
							   :type :stream
							   :protocol :tcp)))
	(sb-bsd-sockets:socket-connect socket (ns-lookup hostname) port)
	socket))

(declaim #+sbcl(sb-ext:muffle-conditions style-warning))
(defun get-nanoseconds-of-day ()
  (multiple-value-bind (_ seconds nanoseconds __ ___) (sb-unix:unix-gettimeofday)
	(+ (* seconds (expt 10 9)) nanoseconds)))
(declaim #+sbcl(sb-ext:unmuffle-conditions style-warning))

(defun tcp-server (port &key (backlog 5) (interface "localhost"))
  (let ((server  (make-instance
				  'sb-bsd-sockets:inet-socket :type :stream  
				  :protocol :tcp)))
	(sb-bsd-sockets:socket-bind server (ns-lookup interface) port)
	(sb-bsd-sockets:socket-listen server backlog)
	(setf (sb-bsd-sockets:sockopt-reuse-address server) t)
	server))

(defun repeat (x n)
  (loop for i from 1 to n collect x))

(defun string-multiply (str n)
  (apply #'concatenate `(string ,@(repeat str n))))
(defmacro with-open-server (server port &body body)
  `(let ((,server (tcp-server ,port)))
	 (unwind-protect
		  (progn
			,@body)
	   (tcp-close ,server))))

(defun socket-fd (socket)
  (etypecase socket
    (fixnum socket)
    (sb-bsd-sockets:socket (sb-bsd-sockets:socket-file-descriptor socket))
    (file-stream (sb-sys:fd-stream-fd socket))))

(defmacro with-threaded-client (server client &body body)
  `(let ((,client (sb-bsd-sockets:socket-accept ,server)))
	 (sb-thread:make-thread (lambda ()
							  (unwind-protect
								   (progn
									 ,@body)
								(tcp-close ,client))))))


(defun tcp-read (socket num &optional (buffer nil))
  (sb-bsd-sockets:socket-receive socket buffer num))


(defun newline (&optional (str ""))
  (format nil "~a~%" str))

(defun tcp-close (socket)
  (sb-sys:invalidate-descriptor (socket-fd socket))
  (sb-bsd-sockets:socket-close socket))



(defun tcp-send (socket msg)
  (sb-bsd-sockets:socket-send socket msg (length msg)))

(defun tcp-readline (socket)
  (labels ((rec (str)
			 (let ((chr (tcp-read socket 1)))
			   (if (string= chr (newline))
				   (nreverse (concatenate 'string chr str))
				   (rec (concatenate 'string chr str))))))
	(rec "")))

(defmacro with-open-socket (socket hostname port &body body)
  `(let ((,socket (tcp-connect ,hostname ,port)))
	 (unwind-protect
		  (progn
			,@body
			)
	   (tcp-close ,socket))))



(defun split-string (string key)
  (loop for i = 0 then (1+ j)
	 as j = (position key string :start i)
	 collect (subseq string i j)
	 while j))

(defun strip-chars (str chars)
  (remove-if (lambda (ch) (find ch chars)) str))

(defun get-headers (socket)
  (labels ((rec (str)
			 (let ((line (tcp-readline socket)))
			   (if (string= line (newline ""))
				   str
				   (rec (cons
						 (strip-chars
						  line
						  (newline "")) str))))))
	(rec nil)))


(defstruct queue first last)

(defgeneric enqueue (q x))

(defmethod enqueue ((q queue) x)
  (if (not (queue-first q))
	  (progn
		(setf (queue-first q) (list x) (queue-last q) (queue-first q))
		q)
	  (progn
		(nconc (queue-last q) (list x))
		(setf (queue-last q) (cdr (queue-last q)))
		q)))

(defgeneric dequeue (q))

(defmethod dequeue ((q queue))
  (if (queue-first q)
	  (values (pop (queue-first q)) q)
	  (values nil q)))


