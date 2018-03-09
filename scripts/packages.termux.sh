#!/bin/bash
set -e

tmpfile="$(mktemp)"

cat >"$tmpfile" <<PACKAGES
#git
#vim
#man
#curl
#grep  #for color output
#openssh
PACKAGES

# edit the list before installing
eval "${EDITOR:-vi} $tmpfile"

# strip comments and install
pkg install $(sed 's/#.*//' "$tmpfile")
