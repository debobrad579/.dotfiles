#!/bin/bash

case $BLOCK_BUTTON in
    1) playerctl -p spotifyd play-pause ;;
    4) playerctl --player=spotifyd volume 0.05+ ;;
    5) playerctl --player=spotifyd volume 0.05- 
esac

if ! pgrep -x "spotifyd" > /dev/null; then
    exit
fi

artist=$(playerctl --player=spotifyd metadata artist 2>/dev/null)
title=$(playerctl --player=spotifyd metadata title 2>/dev/null)

if [[ -z "$artist" || -z "$title" ]]; then
    exit
fi

if [[ "$BAR_ROLE" == "main" ]]; then
    echo " $artist - $title"
else
    echo " $artist"
fi
