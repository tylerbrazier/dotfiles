#!/bin/sh

# Start X by running `startx` in a virtual terminal or automatically at login:
# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login

# key repeat delay(ms) and rate(Hz)
xset r rate 200 30

# turn bell off
xset b off

# load .Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# run scripts in xinitrc.d/
for f in /etc/X11/xinit/xinitrc.d/?*.sh; do [ -x "$f" ] && source "$f"; done

# run any machine-local stuff (e.g. screen settings with xrandr)
[ -f ~/.xinitrc.local ] && source ~/.xinitrc.local

exec i3
