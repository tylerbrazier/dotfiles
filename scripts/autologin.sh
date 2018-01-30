#!/bin/bash
# https://wiki.archlinux.org/index.php/getty#Automatic_login_to_virtual_console
set -e

test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1
test "$#" -ne 1 && echo "Usage: $0 <user>" >&2 && exit 1
! id "$1" >/dev/null 2>&1 && echo "$1 is not a user" && exit 1

mkdir -p /etc/systemd/system/getty@tty1.service.d/

cat >/etc/systemd/system/getty@tty1.service.d/override.conf <<FILE
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $1 --noclear %I \$TERM
FILE
