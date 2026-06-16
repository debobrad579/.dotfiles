#!/bin/bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"
prev=""

upower -m | while read -r line; do
    [[ "$line" != *"$BAT"* ]] && continue

    percent=$(upower -i "$BAT" | awk '/percentage/ {print $2}')
    state=$(upower -i "$BAT" | awk '/state/ {print $2}')
    cur="$percent-$state"

    [[ "$cur" == "$prev" ]] && continue
    prev="$cur"

    echo "Battery changed: $cur"
    pkill -SIGRTMIN+4 i3blocks
done
