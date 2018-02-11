#!/bin/bash
# https://wiki.archlinux.org/index.php/GNOME#Configuration

# turn on numlock on login
gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state on

# faster key repeat delay
gsettings set org.gnome.desktop.peripherals.keyboard delay 200

# show the date on the clock
gsettings set org.gnome.desktop.interface clock-show-date true

# screen timeout (in seconds)
gsettings set org.gnome.desktop.session idle-delay 600

# don't lock the screen when screensaver comes on
gsettings set org.gnome.desktop.screensaver lock-enabled false

# disable the annoying beep
gsettings set org.gnome.desktop.sound event-sounds false

# make touchpad scrolling consistent with mouse
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
