#!/bin/bash

pactl subscribe | while read -r line; do
    if [[ "$line" == *"sink"* && "$line" == *"change"* ]]; then
        pkill -SIGRTMIN+1 i3blocks
    fi
done
