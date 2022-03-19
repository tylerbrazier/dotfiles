#!/bin/sh

cd "$HOME"
echo "cwd: $PWD"
echo "Type 'y' to confirm curl commands:"
echo '
bashrc
vimrc
gitconfig
config/sway/config
config/i3status/config
config/alacritty.yml
termux/termux.properties
shortcuts/sshd
shortcuts/archive_pic
local/bin/dmenu_history
local/bin/yd
' | xargs -p -I{} curl --create-dirs -o .{} \
	https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{}

chmod -f +x "$HOME/.shortcuts/sshd"
chmod -f +x "$HOME/.shortcuts/archive_pic"
chmod -f +x "$HOME/.local/bin/dmenu_history"
chmod -f +x "$HOME/.local/bin/yd"
