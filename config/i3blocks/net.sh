#!/bin/bash

# Network status script for i3blocks.
# Pass a param of either 'en' (for ethernet) or 'wl' (for wireless)
# and the script will output the name of the first device of that type
# colored either green (if up) or red (if down).
#
# I made this script because the stock wifi block needs to know a
# specific device name, which is different from machine to machine:
# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/
# I'd rather just use the first device since none of my computers have
# more than one wifi card or ethernet port anyway.
#
# https://github.com/vivien/i3blocks

[ "$1" != 'en' ] && [ "$1" != 'wl' ] && exit 1

device=$(ls /sys/class/net | grep -m 1 "^$1")
[ -z $device ] && exit 1

echo $device # full_text
echo $1      # short_text

# color
state=$(cat /sys/class/net/$device/operstate)
[ $state == 'up' ] && echo '#00FF00'   # green
[ $state == 'down' ] && echo '#FF0000' # red
exit 0
