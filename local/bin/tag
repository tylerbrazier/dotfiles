#!/bin/sh

if [ $# -ne 1 ]; then
	echo "Usage: tag file.mp3" >&2
	exit 1
fi

t="$(mktemp -d)"
m="$t/metadata"
e="${1##*.}"
f="$t/file.$e"

set -e

ffmpeg -hide_banner -i "$1" -f ffmetadata "$m"

eval "${EDITOR:-vi} $m"

ffmpeg -hide_banner -i "$1" -i "$m" \
    -map_metadata 1 -c copy \
    "$f"

mv -i "$f" "$1"
