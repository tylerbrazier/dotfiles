#!/usr/bin/env bash

# Make symlinks in home to dotfiles.
# Pass -f to overwrite existing dotfiles.
# Pass -p to also install vim plugins.

# in case the script was called from another dir
cd "$(dirname "$0")"


[[ " $@ " == *" -f "* ]] && cmd="ln -svf" || cmd="ln -sv"


$cmd "$(pwd)/profile" ~/.profile
$cmd "$(pwd)/bash_profile" ~/.bash_profile
$cmd "$(pwd)/bashrc" ~/.bashrc
$cmd "$(pwd)/gitconfig" ~/.gitconfig
$cmd "$(pwd)/tmux.conf" ~/.tmux.conf
$cmd "$(pwd)/vimrc" ~/.vimrc


if [[ " $@ " == *" -p "* ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi
