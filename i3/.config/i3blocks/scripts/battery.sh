#!/usr/bin/env bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"

read -r battery charging < <(
  upower -i "$BAT" | awk '
    /percentage/ { gsub(/%/, "", $2); p=$2 }
    /state/      { s=$2 }
    END {
      print p, (s=="charging" || s=="fully-charged") ? 1 : 0
    }'
)

if [ $battery -eq 100 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂅"
    else
        icon="󰁹"
    fi
    color="#00FF00"
elif [ $battery -ge 90 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂋"
    else
        icon="󰂂"
    fi
    color="#00FF00"
elif [ $battery -ge 80 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂊"
    else
        icon="󰂁"
    fi
    color="#99CC00"
elif [ $battery -ge 70 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰢞"
    else
        icon="󰂀"
    fi
    color="#99CC00"
elif [ $battery -ge 60 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂉"
    else
        icon="󰁿"
    fi
    color="#FFF600"
elif [ $battery -ge 50 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰢝"
    else
        icon="󰁾"
    fi
    color="#FFF600"
elif [ $battery -ge 40 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂈"
    else
        icon="󰁽"
    fi
    color="#FF9900"
elif [ $battery -ge 30 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂇"
    else
        icon="󰁼"
    fi
    color="#FF9900"
elif [ $battery -ge 20 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰂆"
    else
        icon="󰁻"
    fi
    color="#FF6600"
elif [ $battery -ge 10 ]; then
    if [ $charging -eq 1 ]; then
        icon="󰢜"
    else
        icon="󰁺"
    fi
    color="#FF6600"
else
    if [ $charging -eq 1 ]; then
        icon="󰢟"
    else
        icon="󰂎"
    fi
    color="#FF0000"
fi

echo "$icon $battery%"
echo $icon
echo $color
