#!/bin/sh

# bail on error
set -e

cd "$HOME"
echo "cwd: $PWD"
echo "Type 'y' to confirm curl commands:"
echo '
bashrc
vimrc
gitconfig
config/sway/config
config/i3status/config
' | xargs -p -I{} curl -o .{} \
	https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{}
