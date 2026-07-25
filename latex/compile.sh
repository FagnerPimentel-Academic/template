#!/bin/bash

echo 'Step 1/5: pdflatex'
pdflatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build ${1}.tex 1> build/${1}.stdout.pdflatex.log 2> build/${1}.stderr.pdflatex.log

echo 'Step 2/5: makeglossaries'
makeglossaries -d build ${1} 1> build/${1}.stdout.makeglossaries.log 2> build/${1}.stderr.makeglossaries.log

echo 'Step 3/5: biber'
biber build/${1} 1> build/${1}.stdout.biber.log 2> build/${1}.stderr.biber.log

echo 'Step 4/5: makeindex'
openout_any=a makeindex build/${1}.idx 1> build/${1}.stdout.makeindex.log 2> build/${1}.stderr.makeindex.log

echo 'Step 5/5: pdflatex'
pdflatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build ${1}.tex 1> build/${1}.stdout.pdflatex.log 2> build/${1}.stderr.pdflatex.log

cp build/*.pdf ../

grep -n -e 'Warning:' -e 'Error:' -e 'Output written on' \
build/${1}.stdout.pdflatex.log > ../${1}.output.log

echo 'Done!'
echo 'Output files copied to "output" folder'
echo 'You can found all logs files in "build" folder'