#!/bin/bash
set -e

test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1

cat >/tmp/services <<SERVICES
#NetworkManager
#gdm
SERVICES

# edit the list before installing
eval "${EDITOR:-vi}" /tmp/services

# strip comments and enable
systemctl enable $(sed 's/#.*//' /tmp/services)
