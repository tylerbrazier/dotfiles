#!/bin/sh

OS="$(uname -o)"

cd "$(git rev-parse --show-toplevel)" || exit

symlink() {
	dotfile="$1"
	cmd="ln -sf"
	cmdline=

	# Files in ~/.shortcuts can't be symlinks so use cp instead:
	# https://github.com/termux/termux-widget/issues/57
	[ "${f%%/*}" = "shortcuts" ] && cmd="cp"

	cmdline="$cmd $PWD/$dotfile $HOME/.$dotfile"

	mkdir -p "$HOME/.$(dirname "$f")"
	echo "$cmdline"
	eval "$cmdline" || exit 1
}

for f in $(git ls-files); do
	case "$f" in
		README|install.sh) continue;;
		shortcuts/*|termux/*)
			if [ "$OS" = "Android" ]; then
				symlink "$f"
			else
				echo "Skipping $f"
				continue
			fi;;
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
