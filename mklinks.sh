#!/usr/bin/env bash
set -e

# Creates symlinks from home to each dotfile.

# Each of these should exist within the directory of this script.
# For each, a symlink will be created in your home directory with a name
# that is the basename of the file with a prepended dot.
dotfiles=(
  bash_profile
  bashrc
  gitconfig
  git-back/git-back
  tmux.conf
  vimrc
)

cd $(dirname $0)

for file in ${dotfiles[@]}; do
  name="$HOME/.$(basename $file)"
  if [ -e "$name" ] && [ ! -h "$name" ]; then
    echo "$name already exists; skipping"
  else
    target=$(readlink -f "$file")
    echo "Linking $name -> $target"
    ln -sfn "$target" "$name"
  fi
done
