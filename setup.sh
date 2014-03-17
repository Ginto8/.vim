#!/bin/bash
vimdir=$(dirname $0)
homedir=$1
[[ -z $homedir ]] && homedir=$HOME

cd $homedir
ln -s $vimdir .vim
ln -s ./.vim/.vimrc .vimrc

