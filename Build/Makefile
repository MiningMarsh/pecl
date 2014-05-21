all:
	@$(LISP) $(ARGUMENTS) $(LISP).lisp

clean:
	@find -O3 src -type l -exec rm "{}" ';'
	@find -O3 macros -type l -exec rm "{}" ';'
	@mkdir -p build
	@rm build/out

clisp:
	@find -O3 src -type l -exec rm "{}" ';'
	@find -O3 macros -type l -exec rm "{}" ';'
	@find -O3 ../Common -type f -exec ln -s "../{}" src ';'
	@find -O3 ../MCommon -type f -exec ln -s "../{}" macros ';'
	@mkdir -p build
	@mkdir -p .build
	@clisp compile.lisp
	@find -O3 src -type l -exec rm "{}" ';'
	@find -O3 macros -type l -exec rm "{}" ';'

sbcl:
	@find -O3 src -type l -exec rm "{}" ';'
	@find -O3 macros -type l -exec rm "{}" ';'
	@find -O3 ../Common -type f -exec ln -s "../{}" src ';'
	@find -O3 ../MCommon -type f -exec ln -s "../{}" macros ';'
	@mkdir -p build
	@find -P -O3 ../Common -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@find -P -O3 ../MCommon -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@sbcl --script compile.lisp
	@find -O3 src -type l -exec rm "{}" ';'
	@find -O3 macros -type l -exec rm "{}" ';'

sbcl-debug:
	@mkdir -p build
	@find -P -O3 -type d -not -name ".build" -not -wholename "./build" -not -wholename "$PWD/build" -exec mkdir -p "{}/.build" ";"
	@sbcl --load compile.lisp
