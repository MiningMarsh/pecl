all:
	@$(LISP) $(ARGUMENTS) $(LISP).lisp

clean:
	@mkdir -p build
	@rm build/out

clisp:
	@mkdir -p build
	@mkdir -p .build
	@clisp ../Build/compile.lisp

sbcl:
	@mkdir -p build
	@find -P -O3 ../Common -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P -O3 ../MCommon -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P -O3 src -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P -O3 macros -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@sbcl --script ../Build/compile.lisp
