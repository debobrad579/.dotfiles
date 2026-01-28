#!/usr/bin/env bash

prev_title=""
prev_artist=""

playerctl -p spotify metadata --follow --format "{{ title }}|||{{ artist }}|||{{ status }}" | while IFS="|||" read -r title artist status; do
    if [ -z "$title" ] && [ -z "$artist" ] && [ -z "$status" ]; then
        continue
    fi

    if [ "$title" != "$prev_title" ] || [ "$artist" != "$prev_artist" ] || [ "$status" != "$prev_status" ]; then
        pkill -SIGRTMIN+3 i3blocks

        prev_title="$title"
        prev_artist="$artist"
        prev_status="$status"
    fi
done
