#!/bin/bash

cd "$(dirname "$0")" || exit

for f in $(git ls-files); do
	[[ $f =~ readme|install.sh ]] && continue

	if [ $# -eq 0 ]; then
		REPLY=
		until [[ $REPLY =~ [ynYN] ]]; do
			read -rn1 -p "$f? (y/n) "
			echo
		done
		[[ $REPLY =~ [nN] ]] && continue
	elif [[ $* != *$f* ]]; then
		continue
	else
		echo "Copying $f"
	fi

	[[ $f == */* ]] && mkdir -p "$HOME/.${f%/*}"
	cp "$PWD/$f" "$HOME/.$f"
done
