#!/bin/bash

oldDir=$(pwd)
dir=$(dirname "$1")
projdir="$dir"
folder=$(basename "$dir")
file=$(basename "$1")
name=${file%.*}
extension=${file##*.}
if [[ "$folder" == "src" ]] || [[ "$folder" == "include" ]]; then
    projdir=$(dirname "$projdir")
fi
#echo "project: $projdir"
if [[ -e "$projdir/CMakeLists.txt" ]]; then
    cd "$projdir"
    if [[ ! -e build ]]; then
        mkdir build
    fi
    cd build
    [[ -e Makefile ]] || cmake ..

    make
else
    cd $dir
    if [[ "$extension" == "c" ]]; then
        clang -o "$name" "$file"
    elif [[ "$extension" == "cpp" ]]; then
        clang++ -o "$name" "$file"
    elif [[ "$extension" == "hpp" ]]; then
        [[ -e "$name.cpp" ]] && clang++ -o "$name" "$name.cpp"
    elif [[ "$extension" == "h" ]]; then
        if [[ -e "$name.c" ]]; then
            clang -o "$name" "$name.c"
        elif [[ -e "$name.cpp" ]]; then
            clang++ -o "$name" "$name.cpp"
        fi
    elif [[ "$extension" == "tex" ]]; then
        build-latex "$name"
    fi
fi

cd $oldDir

