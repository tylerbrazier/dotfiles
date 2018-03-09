#!/bin/bash
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
