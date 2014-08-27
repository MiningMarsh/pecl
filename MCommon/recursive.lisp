(defmacro recursive (args init &rest code)
	`(labels 
			((recurse ,args
				,@code))
		(recurse ,@init)))
