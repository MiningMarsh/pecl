all:
	@$(LISP) $(ARGUMENTS) $(LISP).lisp
clean:
	@rm build/out
clisp:
	@clisp compile.lisp
sbcl:
	@sbcl --script compile.lisp
sbcl-debug:
	@sbcl --load compile.lisp
