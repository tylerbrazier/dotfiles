#!/usr/bin/env bash

# Make symlinks in home to dotfiles.
# Pass -f to overwrite existing dotfiles.
# Pass -g to include config files for gui
# Pass -p to also install vim plugins.

# make sure we're in the root of the project
cd "$(dirname "$0")/.."

[[ " $@ " == *" -f "* ]] && cmd="ln -svf" || cmd="ln -sv"

eval $cmd "$(realpath bash_profile)" ~/.bash_profile
eval $cmd "$(realpath bashrc)" ~/.bashrc
eval $cmd "$(realpath gitconfig)" ~/.gitconfig
eval $cmd "$(realpath tmux.conf)" ~/.tmux.conf
eval $cmd "$(realpath vimrc)" ~/.vimrc

mkdir -p ~/.config/nvim/
eval $cmd "$(realpath config/nvim/init.vim)" ~/.config/nvim/init.vim

if [[ " $@ " == *" -g "* ]]; then
  eval $cmd "$(realpath xinitrc)" ~/.xinitrc
  eval $cmd "$(realpath Xresources)" ~/.Xresources
  eval $cmd "$(realpath gvimrc)" ~/.gvimrc

  mkdir -p ~/.config/i3/
  eval $cmd "$(realpath config/i3/config)" ~/.config/i3/config
fi

if [[ " $@ " == *" -p "* ]]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall
fi
