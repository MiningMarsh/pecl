#!/bin/bash
mkdir tmp
cp util.lisp tmp
cp math-util.lisp tmp
cp -r `ls -l | egrep '^d' | cut -b 49-51` tmp
mv tmp project-euler
buildapp --load runload.lisp --entry main-loop --output runproject
cp runproject project-euler
tar cvzf project-euler.tar.gz project-euler
rm -rf project-euler
