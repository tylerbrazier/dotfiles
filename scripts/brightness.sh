#!/bin/bash

# xbacklight does not work on my laptop with nvidia graphics card so
# I need to manipulate brightness manually using ACPI:
# https://wiki.archlinux.org/index.php/backlight#ACPI

usage="Usage: $0 inc|dec [amount (default 10)]"
file=/sys/class/backlight/nv_backlight/brightness

if [ ! -f "$file" ]; then
	echo "file not found: $file"
	exit 1
fi

amount="${2:-10}"
current=$(cat $file)

if [ "$1" == 'inc' ]; then
	new=$((current + amount))
elif [ "$1" == 'dec' ]; then
	new=$((current - amount))
else
	echo "$usage"
	exit 1
fi

echo $new > $file
