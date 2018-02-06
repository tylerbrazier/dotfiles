source ~/.bashrc

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
# use || instead of && so shell doesn't start in error if we don't startx
[ ! -f ~/.xinitrc -o -n "$DISPLAY" -o "$XDG_VTNR" != 1 ] || exec startx
