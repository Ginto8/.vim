#!/bin/bash

oldwd=$(pwd)
dir=$(dirname "$(readlink -m $1)")
projdir=$dir/
folder=$(basename "$dir")
file=$(basename "$1")
name=${file%.*}
extension=${file##*.}
term=${TERM%-*}
if [[ $projdir =~ /src/ ]]; then
    projdir=${projdir%/src/*}/
elif [[ $projdir =~ /include/ ]]; then
    projdir=${projdir%/include/*}/
fi
runCommand="@"
if [[ $term == screen ]]; then
    if [[ -n $TMUX ]]; then
        runCommand="tmux new-window 'bash -c \"@ || read\"'"
    fi
fi
#echo "Run command: $runCommand (eg. ${runCommand/@/./test.sh})"
echo "project: $projdir"
command=""
if [[ $2 == r ]]; then
    if [[ -e $projdir/CMakeLists.txt ]]; then
        cd "$projdir/build"
        binName="$(grep 'set(EXECUTABLE_NAME' ../CMakeLists.txt |
                   sed 's/set(EXECUTABLE_NAME "\(.*\)")/\1/')"
        command="./$binName"
    elif [[ -e $projdir/build.xml ]]; then
        cd $projdir
        command="ant run"
    else
        cd $dir
        if [[ $extension == c ]] ||
           [[ $extension == h ]] ||
           [[ $extension == hpp ]] ||
           [[ $extension == cpp ]]; then
            [[ -e $name ]] && command="./$name"
        elif [[ $extension == tex ]]; then
            [[ -e $name.pdf ]] && command="evince $name.pdf"
        elif [[ $extension == py ]]; then
            command="python $file"
        elif [[ $extension == sh ]]; then
            command="./$file"
        fi
    fi
    toRun=${runCommand/@/$command}
    bash -c "$toRun"
else
    if [[ -e $projdir/CMakeLists.txt ]]; then
        cd "$projdir"
        if [[ ! -e build ]]; then
            mkdir build
        fi
        cd build
        [[ ! -e Makefile ]] && CC=clang CXX=clang++ cmake ..
        make
    elif [[ -e $projdir/build.xml ]]; then
        cd $projdir
        if [[ -n $TMUX ]]; then
            tmux new-window 'bash -c "ant deploy || read"'
        else 
            ant deploy
        fi
    else
        cd $dir
        if [[ $extension == c ]]; then
            clang -o "$name" "$file"
        elif [[ $extension == cpp ]]; then
            clang++ -o "$name" "$file"
        elif [[ $extension == hpp ]]; then
            [[ -e $name.cpp ]] && clang++ -o "$name" "$name.cpp"
        elif [[ $extension == h ]]; then
            if [[ -e $name.c ]]; then
                clang -o "$name" "$name.c"
            elif [[ -e $name.cpp ]]; then
                clang++ -o "$name" "$name.cpp"
            fi
        elif [[ $extension == tex ]]; then
            build-latex "$name"
        fi
    fi
fi

cd "$oldwd"

