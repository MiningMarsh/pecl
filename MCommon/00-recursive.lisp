(defmacro recursive (args init &rest code)
	`(labels
			((recur ,args
				,@code))
		(recur ,@init)))
