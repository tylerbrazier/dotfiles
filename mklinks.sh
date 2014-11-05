#!/usr/bin/env bash

# Creates symlinks from home to each dotfile.

thisdir=$(cd $(dirname $0); pwd)
dotfiles=(
.bash_profile
.bashrc
.gitconfig
.inputrc
.tmux.conf
.vimrc
.zshrc
.xinitrc
.Xresources
.i3
)

for file in ${dotfiles[@]}; do
  echo "Linking $file"
  [[ -L $HOME/$file ]] && rm -f $HOME/$file  # remove existing symlinks
  ln -s $thisdir/$file $HOME/$file
done
