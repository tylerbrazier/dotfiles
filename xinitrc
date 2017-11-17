#!/bin/sh

# Start X by running `startx` in a virtual terminal or automatically at login:
# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login

# key repeat delay(ms) and rate(Hz)
xset r rate 200 30

# turn bell off
xset b off

# turn numlock on
numlockx &

# load .Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# run scripts in xinitrc.d/
for f in /etc/X11/xinit/xinitrc.d/?*.sh; do [ -x "$f" ] && source "$f"; done

# put any machine-local stuff in ~/.xinitrc.local
# such as xrandr commands to configure screens or set DPI
# https://wiki.archlinux.org/index.php/xrandr
# https://wiki.archlinux.org/index.php/HiDPI#X_Server
[ -f ~/.xinitrc.local ] && source ~/.xinitrc.local

exec i3
