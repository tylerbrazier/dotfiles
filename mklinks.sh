#!/usr/bin/env bash

# Creates symlinks from home to each dotfile.

dotfiles=(
.bash_profile
.bashrc
.gitconfig
.tmux.conf
.vimrc
)

cd $(dirname $0)

for file in ${dotfiles[@]}; do
  if [[ -e $HOME/$file ]] && [[ ! -h $HOME/$file ]]; then
    echo "$HOME/$file already exists; skipping"
  else
    echo "Linking $file"
    ln -sfn $(readlink -f $file) $HOME/$file
  fi
done
