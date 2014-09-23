#!/bin/sh

# ~/.xinitrc

# source files from xinitrc.d
for f in /etc/X11/xinit/xinitrc.d/*; do [ -x "$f" ] && . "$f"; done

# turn off the bell
xset b off

# key repeat delay (in ms), repeats/sec
xset r rate 200 40

# load ~/.Xresources on boot
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# load the background
[ -f ~/.fehbg ] && sh ~/.fehbg &

exec i3
#exec i3 -V >> ~/.i3log 2>&1
#exec startxfce4
#exec gnome-session
