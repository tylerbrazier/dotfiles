#!/bin/bash
set -e

test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1

cat >/tmp/packages <<PACKAGES
### essentials
#vim
#git
#sudo
#tmux
#htop
#openssh
#bash-completion
#networkmanager  # nmtui is easier than netctl

### gnome packages
#gdm
#gnome-shell
#gnome-terminal
#gnome-keyring
#gnome-control-center
#dconf-editor
#nautilus
#ttf-dejavu

### i3 packages
#i3
#dmenu
#rxvt-unicode
#ttf-dejavu
#ttf-font-awesome # for status bar icons
#xorg-server
#xorg-xinit
#xorg-xset
#xorg-xrandr  # for screen configuration
#xorg-xbacklight
#numlockx
#alsa-utils
#polkit  # allows poweroff,reboot,etc. commands without sudo

### extras
#tree
#mlocate
#ntfs-3g  # to write to ntfs formatted drives
#neovim
#xsel  # clipboard support for neovim
#gvim  # includes clipboard support (conflicts with vim)
#firefox
#chromium
#cups  # for printing
#hplip # hp printer driver
#xf86-video-fbdev  # xorg driver for raspberry pi

### retro game stuff
#retroarch
#retroarch-assets-xmb
#retroarch-autoconfig-udev
#libretro-nestopia  # nes core
PACKAGES

# edit the list before installing
eval "${EDITOR:-vi}" /tmp/packages

# strip comments and install
pacman -Sy --needed $(sed 's/#.*//' /tmp/packages)
