#!/bin/bash

case $BLOCK_BUTTON in
    1) playerctl -p spotify play-pause
esac

if ! pgrep -x "spotify" > /dev/null; then
    exit
fi

artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
title=$(playerctl --player=spotify metadata title 2>/dev/null)

if [[ -z "$artist" || -z "$title" ]]; then
    exit
fi

status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
    icon=""
elif [[ "$status" == "Paused" ]]; then
    icon=""
else
    icon=""
fi

echo "$artist - $title $icon"
echo "$artist $icon"
