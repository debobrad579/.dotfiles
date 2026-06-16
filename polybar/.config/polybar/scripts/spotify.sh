#!/usr/bin/env bash

playerctl -p spotifyd metadata --follow --format "{{ title }}|||{{ artist }}" | while read -r line; do
    title="${line%%|||*}"
    artist="${line##*|||}"

    if [ -z "$title" ] || [ -z "$artist" ]; then
        echo ""
    else
        echo "%{F#1DB954} $artist - $title%{F-}"
    fi
done
