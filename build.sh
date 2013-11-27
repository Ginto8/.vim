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
    (which clang &>/dev/null && CC=clang) || CC=gcc
    (which clang++ &>/dev/null && CXX=clang) || CXX="g++ -std=c++0x"
    CC="$CC   -Wall"
    CXX="$CXX -Wall"
    export CC
    export CXX
    if [[ -e $projdir/CMakeLists.txt ]]; then
        cd "$projdir"
        if [[ ! -e build ]]; then
            mkdir build
        fi
        cd build
        [[ ! -e Makefile ]] && cmake ..
        echo "$projdir"
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
            $CC -o "$name" "$file"
            ;;
        cpp )
            $CXX -o "$name" "$file"
            ;;
        hpp )
            [[ -e $name.cpp ]] && $CXX -o "$name" "$name.cpp"
            ;;
        h )
            if [[ -e $name.c ]]; then
                $CC -o "$name" "$name.c"
            elif [[ -e $name.cpp ]]; then
                $CXX -o "$name" "$name.cpp"
            fi
            ;;
        tex )
            build-latex "$name"
            ;;
        hs )
            ghc "$file"
            ;;
        esac
    fi
fi

