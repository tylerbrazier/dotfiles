#!/bin/bash
set -e

test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1

read -p 'New user: ' user

test -z "$user" && exit 1
id "$user" >/dev/null 2>&1 && echo "$user already exists" && exit 1

useradd -m -g wheel -s /bin/bash "$user"
passwd "$user"

# allow member of wheel group to sudo without password
sed -i~ 's/^# *\(%wheel ALL=(ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers
