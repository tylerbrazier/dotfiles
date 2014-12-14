#!/usr/bin/env bash

# Creates symlinks from home to each dotfile.

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
.gtkrc-2.0
.i3
)

cd $(dirname $0)

for file in ${dotfiles[@]}; do
  if [[ -e $HOME/$file ]] && [[ ! -h $HOME/$file ]]; then
    echo "$HOME/$file already exists; skipping"
  else
    echo "Linking $file"
    ln -sfn $(realpath $file) $HOME/$file
  fi
done
