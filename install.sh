#!/bin/bash

cd "$(dirname "$0")" || exit

echo "Press y or n:"
for f in $(git ls-files); do
	[[ $f =~ readme|install.sh ]] && continue

	REPLY=; until [[ $REPLY =~ [ynYN] ]]; do
		read -rn1 -p "$f? "; echo
	done

	[[ $REPLY =~ [nN] ]] && continue

	[[ $f == */* ]] && mkdir -p "$HOME/.${f%/*}"
	cp "$PWD/$f" "$HOME/.$f"
done
