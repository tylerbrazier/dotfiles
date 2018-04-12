#!/bin/bash

# Makes symlinks in home to dotfiles.
# Any -i or -f given to the script will be passed along to each underlying ln
# command for interactive overwrite (-i) or force overwrite (-f).

# make sure we're in the root of the project
cd "$(dirname "$0")/.."

cmd="ln -s -v"
[[ " $@ " == *" -f "* ]] && cmd="$cmd -f"
[[ " $@ " == *" -i "* ]] && cmd="$cmd -i"

eval $cmd "$(realpath bash_profile)" ~/.bash_profile
eval $cmd "$(realpath bashrc)" ~/.bashrc
eval $cmd "$(realpath gitconfig)" ~/.gitconfig
eval $cmd "$(realpath tmux.conf)" ~/.tmux.conf
eval $cmd "$(realpath vimrc)" ~/.vimrc
eval $cmd "$(realpath gvimrc)" ~/.gvimrc
eval $cmd "$(realpath xinitrc)" ~/.xinitrc
eval $cmd "$(realpath Xresources)" ~/.Xresources

mkdir -p ~/.vim/plugin/
eval $cmd "$(realpath vim/plugin/plugs.vim)" ~/.vim/plugin/plugs.vim

mkdir -p ~/.config/nvim/
eval $cmd "$(realpath config/nvim/init.vim)" ~/.config/nvim/init.vim

mkdir -p ~/.config/gtk-3.0/
eval $cmd "$(realpath config/gtk-3.0/settings.ini)" ~/.config/gtk-3.0/settings.ini

mkdir -p ~/.config/i3/
eval $cmd "$(realpath config/i3/config)" ~/.config/i3/config

mkdir -p ~/.config/i3status/
eval $cmd "$(realpath config/i3status/config)" ~/.config/i3status/config