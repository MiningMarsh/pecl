#!/bin/bash
sbcl --dynamic-space-size 2000 --script runproject.lisp $@
