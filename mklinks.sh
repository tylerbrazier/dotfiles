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
    rm -rf $HOME/$base
    echo "Linking $base"
    ln -s $file $HOME/$base
  fi
#  if [[ -e ${thisdir}/${file} ]]; then
#
#    rm -rf ${HOME}/${file}
#
#    echo "ln -s ${thisdir}/${file} ${HOME}/${file}"
#
#    ln -s ${thisdir}/${file} ${HOME}/${file}
#
#  else
#    echo "No ${file} in ${thisdir}. Skipping."
#  fi
done
