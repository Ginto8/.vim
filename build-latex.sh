#!/bin/bash
rm -r build
mkdir build
(
pdflatex -halt-on-error -output-directory build/ $1.tex
if [[ "$?" == "0" ]] && [[ "$2" == "bib" ]]; then
    biber build/$1
    pdflatex -halt-on-error -output-directory build/ $1.tex &&
    pdflatex -halt-on-error -output-directory build/ $1.tex
fi
) | egrep -i '(^ERROR|^WARNING|^!|^l\.)'
cp build/*.pdf .
cd ..
