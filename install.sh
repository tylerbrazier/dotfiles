#!/bin/sh

OS="$(uname -o)"

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
		config/i3*|\
		config/sway*|\
		config/foot*)
			if [ "$OS" = "Android" ]; then
				echo "Skipping $f"
				continue
			else
				symlink "$f"
			fi;;
		*) symlink "$f";;
	esac
done
