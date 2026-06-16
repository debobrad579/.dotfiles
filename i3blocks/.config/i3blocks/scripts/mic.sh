#!/bin/bash

case $BLOCK_BUTTON in
    1) wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
esac

in_use=$(wpctl status | grep -E "input_.*\s+<.*capture.*\s+\[active\]" | wc -l)

[ "$in_use" -eq 0 ] && exit

if wpctl get-volume "@DEFAULT_AUDIO_SOURCE@" | grep -q MUTED; then
    echo "󰍭"; echo "󰍭"; echo "#5C6370"
else
    echo "󰍬"; echo "󰍬"; echo "#FF0000"
fi
