#!/bin/bash
set -e

test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1
test ! -d /etc/sudoers.d && echo 'Make sure sudo is installed' >&2 && exit 1

read -p 'New user: ' user
test -z "$user" && exit 1
id "$user" >/dev/null 2>&1 && echo "$user already exists" && exit 1

useradd -m -g wheel -s /bin/bash "$user"
passwd "$user"

echo 'Writing to /etc/sudoers.d/custom:'
tee /etc/sudoers.d/custom <<EOF
# allow members of wheel group to sudo without password
%wheel ALL=(ALL) NOPASSWD: ALL
EOF