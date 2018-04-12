#!/bin/bash

# Install script for Termux packages that I use.
# The list will be opened in your editor so you can uncomment the packages
# you want to be installed.

set -e

tmpfile="$(mktemp)"

cat >"$tmpfile" <<PACKAGES
#git
#vim
#man
#curl
#grep  #for color output
#openssh
#bash-completion
PACKAGES

# edit the list before installing
eval "${EDITOR:-vi} $tmpfile"

# strip comments and install
pkg install $(sed 's/#.*//' "$tmpfile")
