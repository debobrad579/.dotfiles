#!/bin/bash

case $BLOCK_BUTTON in
    1) playerctl -p spotifyd play-pause
esac

if ! pgrep -x "spotifyd" > /dev/null; then
    exit
fi

artist=$(playerctl --player=spotifyd metadata artist 2>/dev/null)

if [[ -z "$artist" ]]; then
    exit
fi

status=$(playerctl --player=spotifyd status 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
    echo ""
else
    echo ""
fi
