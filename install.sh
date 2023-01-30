#!/bin/sh

cd "$(dirname "$0")" || exit
echo "Type 'y' to confirm:"
git ls-files \
	| awk '! /readme|install\.sh/' \
	| xargs -p -I{} install -D -m644 {} "$HOME/.{}"

chmod -f +x "$HOME"/.local/bin/*
