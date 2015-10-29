#!/usr/bin/env bash

# make sure we're in the project root dir
cd $(dirname $0)

# in case you forgot to clone --recursive
git submodule update --init

mkdir -p ~/.vim/bundle/

echo "making symlinks from home to dotfiles"
ln -sn "$(pwd)/profile" ~/.profile && echo "linked profile"
ln -sn "$(pwd)/bash_profile" ~/.bash_profile && echo "linked bash_profile"
ln -sn "$(pwd)/bashrc" ~/.bashrc && echo "linked gitconfig"
ln -sn "$(pwd)/gitconfig" ~/.gitconfig && echo "linked gitconfig"
ln -sn "$(pwd)/tmux.conf" ~/.tmux.conf && echo "linked tmux.comf"
ln -sn "$(pwd)/vimrc" ~/.vimrc && echo "linked vimrc"
ln -sn "$(pwd)/Vundle.vim" ~/.vim/bundle/Vundle.vim && echo "linked Vundle.vim"

echo "installing vim plugins"
vim +PluginInstall +qall

# GOPATH should be defined in bash_profile
[ -z $GOPATH ] && source bash_profile
echo "creating GOPATH workspace at $GOPATH"
mkdir -p "$GOPATH/src"
mkdir -p "$GOPATH/bin"
mkdir -p "$GOPATH/pkg"
echo "installing go binaries"
vim +GoInstallBinaries +qall
