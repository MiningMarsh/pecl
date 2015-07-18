all:
	@$(LISP) $(ARGUMENTS) $(LISP).lisp

clean:
	@mkdir -p build
	@rm -rf build

clisp:
	@mkdir -p build
	@mkdir -p .build
	@clisp ../Build/compile.lisp

sbcl:
	@mkdir -p build
	@mkdir -p macros
	@mkdir -p src
	@find -P ../Common -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P ../MCommon -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P src -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P macros -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@sbcl --script ../Build/compile.lisp
