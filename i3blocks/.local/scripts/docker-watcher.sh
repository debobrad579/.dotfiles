#!/usr/bin/env bash

docker events \
    --filter 'type=container' \
    --filter 'event=start' \
    --filter 'event=stop' \
    --filter 'event=die' \
    --format '{{.Action}}' |
while read -r _; do
    pkill -SIGRTMIN+6 i3blocks 
done
