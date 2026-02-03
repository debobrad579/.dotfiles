#!/bin/bash

case $BLOCK_BUTTON in
    1) playerctl -p spotify play-pause ;;
    4) playerctl --player=spotify volume 0.05+ ;;
    5) playerctl --player=spotify volume 0.05- 
esac

if ! pgrep -x "spotify" > /dev/null; then
    exit
fi

artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
title=$(playerctl --player=spotify metadata title 2>/dev/null)

if [[ -z "$artist" || -z "$title" ]]; then
    exit
fi

if [[ "$BAR_ROLE" == "main" ]]; then
    echo " $artist - $title"
else
    echo " $artist"
fi
