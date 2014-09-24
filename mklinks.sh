#!/usr/bin/env bash

# Creates symlinks from home to each dotfile.

thisdir=$(cd $(dirname $0); pwd)
# these won't be linked:
ignore=(
.
..
.git
.gitignore
.gitattributes
)

contains() {
  for i in ${ignore[@]}; do
    [[ $1 == $i ]] && return 0
  done
  return 1
}

for file in ${thisdir}/.*; do
  base=$(basename $file)

  if contains $base; then
    echo "Skipping $base"
  else
    echo "Linking $base"
    rm -rf $HOME/$base
    ln -s $file $HOME/$base
  fi
done
