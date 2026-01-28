#!/bin/bash

case $BLOCK_BUTTON in
    1) pactl set-sink-mute @DEFAULT_SINK@ toggle
esac

volume=$(pactl get-sink-volume @DEFAULT_SINK@ \
        | awk '{print $5}' | head -n1 | tr -d '%')

muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [[ $muted == "yes" ]]; then
    echo "󰸈 ($volume%)"
    echo "󰸈"
    echo "#6F8FAF"
    exit
fi

if [[ $volume -ge 70 ]]; then
    icon="󰕾"
elif [[ $volume -ge 30 ]]; then
    icon="󰖀"
else
    icon="󰕿"
fi

echo "$icon $volume%"
