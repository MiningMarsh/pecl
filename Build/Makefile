all:
	@$(LISP) $(ARGUMENTS) $(LISP).lisp

clean:
	@mkdir -p build
	@rm build/out

clisp:
	@mkdir -p build
	@mkdir -p .build
	@clisp compile.lisp

sbcl:
	@mkdir -p build
	@find . -P -O3 -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@sbcl --script compile.lisp

sbcl-debug:
	@mkdir -p build
	@find . -P -O3 -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@sbcl --load compile.lisp
