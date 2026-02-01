#!/usr/bin/env bash

INTERFACE="wlan0"

link_info=$(iw dev "$INTERFACE" link)

if [[ $link_info != *Connected* ]]; then
    echo "󰤭"
    echo "󰤭"
    echo "#FF0000"
    exit
fi

read -r ssid rssi <<< "$(
    awk -F': ' '
        /SSID/ {ssid=$2}
        /signal/ {rssi=$2}
        END {print ssid, rssi}
    ' <<< "$link_info"
)"

rssi=${rssi% dBm}
quality=$(( rssi > -50 ? 100 : rssi < -100 ? 0 : (rssi + 100) * 2 ))

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

if [[ "$BAR_ROLE" == "main" ]]; then
    echo "$icon $ssid ($quality%)"
    echo "$icon $ssid ($quality%)"
    echo $color
else
    echo "$icon $quality%"
    echo "$icon $quality%"
    echo $color
fi
