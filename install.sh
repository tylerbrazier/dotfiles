#!/bin/sh
cd "$HOME"
echo "cwd: $PWD"
echo "Type 'y' to confirm curl commands:"
echo '
bashrc
vimrc
gitconfig
config/sway/config
config/swaynag/config
config/i3status/config
config/foot/foot.ini
config/mpv/mpv.conf
termux/termux.properties
termux/colors.properties
shortcuts/notes
shortcuts/sshd
shortcuts/docpic
local/bin/dmenu_history
local/bin/yd
' | xargs -p -I{} curl --create-dirs -o .{} \
	https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{}
chmod -f +x "$HOME/.local/bin/dmenu_history"
chmod -f +x "$HOME/.local/bin/yd"
