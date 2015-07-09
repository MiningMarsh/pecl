(defmacro verify-macro (macro expected)
"Takes a macro form and an expanded form, and verifies that the macro form
expands into the expanded form. Errors if it does not."
	`(if (not (equal (macroexpand-1 ',macro) ',expected))
		(error "Macro implemented incorrectly.")))
