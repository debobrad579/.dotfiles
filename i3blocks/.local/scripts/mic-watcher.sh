#!/bin/bash

DEBOUNCE=3

last_trigger=0

pw-mon | while IFS= read -r line; do
    if [[ "$line" == *"Input"* && "$line" == *"Audio"* ]]; then
        now=$(date +%s)
        difference=$(( now - last_trigger ))
        if (( difference >= DEBOUNCE )); then
            pkill -SIGRTMIN+5 i3blocks
            last_trigger=$now
        fi
    fi
done
