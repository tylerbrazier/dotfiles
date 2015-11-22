#!/usr/bin/env bash

# WARNING: this will overwrite any of the existing dotfiles!


# in case the script was called from another dir
cd $(dirname $0)


echo "Making symlinks from home to dotfiles"
ln -snf "$(pwd)/profile" ~/.profile
ln -snf "$(pwd)/bash_profile" ~/.bash_profile
ln -snf "$(pwd)/bashrc" ~/.bashrc
ln -snf "$(pwd)/gitconfig" ~/.gitconfig
ln -snf "$(pwd)/tmux.conf" ~/.tmux.conf
ln -snf "$(pwd)/vimrc" ~/.vimrc


read -p "Download vim plugins? (y/n) " plugs
if [ "$plugs" = "y" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi
