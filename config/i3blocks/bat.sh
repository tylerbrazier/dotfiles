#!/bin/bash

# Adds an icon, based on the percentage, to the default i3blocks battery script
# https://github.com/vivien/i3blocks

wrapped=$(/usr/lib/i3blocks/battery)
stat=$?
[ $stat -eq 0 ] || exit $stat

percent=$(echo $wrapped | sed 's/\([0-9]*\)%.*/\1/')
if [ $percent -ge 90 ]; then
  icon= #fa-battery-full x0000f240
elif [ $percent -ge 60 ]; then
  icon= # fa-battery-three-quarters x0000f241
elif [ $percent -ge 40 ]; then
  icon= # fa-battery-half x0000f242
elif [ $percent -ge 10 ]; then
  icon= # fa-battery-quarter x0000f243
else
  icon= # fa-battery-empty x0000f244
fi

echo "$wrapped" | sed "s/\\([0-9]*%\\)/$icon \\1/"
