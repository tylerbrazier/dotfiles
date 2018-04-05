#!/bin/bash

# Enables services for Arch linux packages that I use.
# The list will be opened in your editor so you can uncomment the services
# you want to be enabled.

set -e
test $(id -u) -ne 0 && echo 'Run as root' >&2 && exit 1

tmpfile="$(mktemp)"

cat >"$tmpfile" <<SERVICES
#NetworkManager
#gdm
#org.cups.cupsd
SERVICES

# edit the list before installing
eval "${EDITOR:-vi} $tmpfile"

# strip comments and enable
systemctl enable $(sed 's/#.*//' "$tmpfile")
