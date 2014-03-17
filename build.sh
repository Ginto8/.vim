#!/bin/bash

command=""
if [[ $1 == r ]]; then
    if [[ -e $projdir/CMakeLists.txt ]]; then
        cd "$projdir/build"
        binName="$(grep 'set(EXECUTABLE_NAME' ../CMakeLists.txt |
                   sed 's/set(EXECUTABLE_NAME \"\(.*\)\")/\1/')"
        command="./$binName"
    elif [[ -e $projdir/build.xml ]]; then
        command="ant run"
    else
        case $extension in
        c | h | hpp | cpp )
            [[ -e ./$name ]] && command="./$name"
            ;;
        tex )
            [[ -e $name.pdf ]] && command="evince $name.pdf"
            ;;
        py )
            command="python $file"
            ;;
        sh )
            command="./$file"
            ;;
        hs )
            command="./$name"
            ;;
        md )
            command="chromium `pwd`/${name}.html"
            ;;
        esac
    fi
    if [[ -z $command ]]; then
        echo ERROR: executable for $file not found
    else
        toRun=${runCommand/@/$command}
        #echo "running: " $toRun
        bash -c "$toRun"
    fi
else
    if which clang &>/dev/null; then
        export CC=clang
    else
        export CC=gcc
    fi
    if which clang++ &>/dev/null; then
        export CXX=clang++
    else
        export CXX=g++
    fi
    if [[ -e $projdir/CMakeLists.txt ]]; then
        cd "$projdir"
        if [[ ! -e build ]]; then
            mkdir build
        fi
        cd build
        if [[ ! -e Makefile ]]; then
            cmake ..
        fi
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
        case $extension in
        c )
            $CC -Wall -o "$name" "$file"
            ;;
        cpp )
            $CXX -Wall -o "$name" "$file"
            ;;
        hpp )
            [[ -e $name.cpp ]] && $CXX -o "$name" "$name.cpp"
            ;;
        h )
            if [[ -e $name.c ]]; then
                $CC -Wall -o "$name" "$name.c"
            elif [[ -e $name.cpp ]]; then
                $CXX -Wall -o "$name" "$name.cpp"
            fi
            ;;
        tex )
            build-latex "$name"
            ;;
        hs )
            ghc "$file"
            ;;
        md )
            markdown "$file" >"$name.html"
            ;;
        esac
    fi
fi

