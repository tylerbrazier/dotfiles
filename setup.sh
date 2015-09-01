#!/usr/bin/env bash
set -e

# Creates symlinks from home to each dotfile.

# Each of these should exist within the directory of this script.
# For each, a symlink will be created in your home directory with a name
# that is the basename of the file with a prepended dot.
dotfiles=(
  profile
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


mkdir -p ~/.vim/bundle/
name="$HOME/.vim/bundle/Vundle.vim"
target="$(readlink -f Vundle.vim)"
echo "Linking $name -> $target"
ln -sfn "$target" "$name"
echo "Installing vim plugins"
vim -c "PluginInstall"
