#!/bin/bash

case $BLOCK_BUTTON in
    1) playerctl -p spotifyd next
esac

if ! pgrep -x "spotifyd" > /dev/null; then
    exit
fi

artist=$(playerctl --player=spotifyd metadata artist 2>/dev/null)

if [[ -z "$artist" ]]; then
    exit
fi

echo " "
