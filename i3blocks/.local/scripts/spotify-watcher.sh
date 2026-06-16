#!/usr/bin/env bash

prev_title=""
prev_artist=""
prev_status=""

playerctl -p spotifyd metadata --follow --format "{{ title }}|||{{ artist }}|||{{ status }}" | while IFS="|||" read -r title artist status; do
    if [ -z "$title" ] && [ -z "$artist" ] && [ -z "$status" ]; then
        pkill -SIGRTMIN+3 i3blocks
        pkill -SIGRTMIN+7 i3blocks
        pkill -SIGRTMIN+8 i3blocks
        pkill -SIGRTMIN+9 i3blocks
        continue
    fi

    if [ "$status" != "$prev_status" ]; then
        pkill -SIGRTMIN+7 i3blocks

        prev_status="$status"
    fi

    if [ "$title" != "$prev_title" ] || [ "$artist" != "$prev_artist" ]; then
        pkill -SIGRTMIN+3 i3blocks

        if [ -z "$prev_title" ] && [ -z "$prev_artist" ]; then
            pkill -SIGRTMIN+7 i3blocks
            pkill -SIGRTMIN+8 i3blocks
            pkill -SIGRTMIN+9 i3blocks
        fi

        prev_title="$title"
        prev_artist="$artist"
    fi
done
