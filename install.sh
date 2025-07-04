#!/bin/sh

cd "$(git rev-parse --show-toplevel)" || exit

symlink() {
	dotfile="$1"
	cmd="ln -sf $PWD/$dotfile $HOME/.$dotfile"

	mkdir -p "$HOME/.$(dirname "$dotfile")"
	echo "$cmd"
	eval "$cmd" || exit 1
}

for f in $(git ls-files); do
	case "$f" in
		README|install.sh) continue;;
		*) symlink "$f";;
	esac
done
