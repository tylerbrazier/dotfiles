#!/usr/bin/env bash

# WARNING: this will overwrite any of the existing dotfiles!

# make sure we're in the project root dir
cd $(dirname $0)

# in case you forgot to clone --recursive
git submodule update --init

mkdir -p ~/.vim/bundle/

echo "Making symlinks from home to dotfiles"
ln -snf "$(pwd)/profile" ~/.profile
ln -snf "$(pwd)/bash_profile" ~/.bash_profile
ln -snf "$(pwd)/bashrc" ~/.bashrc
ln -snf "$(pwd)/gitconfig" ~/.gitconfig
ln -snf "$(pwd)/tmux.conf" ~/.tmux.conf
ln -snf "$(pwd)/vimrc" ~/.vimrc
ln -snf "$(pwd)/Vundle.vim" ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
