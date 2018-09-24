#!/bin/bash

# Adds a new user to the wheel group and modifies /etc/sudoers.d/custom
# allowing members of wheel to run sudo without a password (for convenience).

set -e
test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1
test ! -d /etc/sudoers.d && echo 'Make sure sudo is installed' >&2 && exit 1

read -p 'New user: ' user
test -z "$user" && exit 1
id "$user" >/dev/null 2>&1 && echo "$user already exists" && exit 1

groupadd wheel 2>/dev/null
useradd -m -g wheel -s /bin/bash "$user"
passwd "$user"

echo 'Writing to /etc/sudoers.d/custom:'
tee /etc/sudoers.d/custom <<EOF
# allow members of wheel group to sudo without password
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
