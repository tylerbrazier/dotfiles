#!/bin/sh

# bail on error
set -e

cd "$HOME"
echo "cwd: $PWD"
echo '
bashrc
vimrc
gitconfig
' | xargs -t -I{} curl -o .{} \
	https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{}
