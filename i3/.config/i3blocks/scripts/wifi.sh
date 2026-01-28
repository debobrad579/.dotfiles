#!/usr/bin/env bash

INTERFACE="wlan0"

if [[ ! -d /sys/class/net/${INTERFACE}/wireless ]] || [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
    echo "󰤭"
    echo "󰤭"
    echo "#FF0000"
    exit
fi

quality=$(iw dev ${INTERFACE} link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')

if [[ $quality -ge 80 ]]; then
    icon="󰤨"
    color="#00FF00"
elif [[ $quality -ge 60 ]]; then
    icon="󰤥"
    color="#FFF600"
elif [[ $quality -ge 40 ]]; then
    icon="󰤢"
    color="#FF9900"
elif [[ $quality -ge 20 ]]; then
    icon="󰤟"
    color="#FF6600"
else
    icon="󰤯"
    color="#FF0000"
fi

ssid=$(iw dev ${INTERFACE} link | awk -F': ' '/SSID/ {print $2}')

echo "$icon $ssid ($quality%)"
echo "$icon $quality%"
echo $color
