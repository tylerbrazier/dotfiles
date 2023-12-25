#!/bin/bash

cd "$(dirname "$0")" || exit

for f in $(git ls-files); do
	[[ $f =~ readme|install.sh ]] && continue

	if [ $# -eq 0 ]; then
		if git -P diff "$HOME/.$f" "$f" 2>/dev/null; then
			echo "$f is up to date."
			continue
		fi

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
