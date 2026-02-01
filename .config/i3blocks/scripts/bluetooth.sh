#!/usr/bin/env bash

devices=$(bluetoothctl devices Connected | awk '{print $2}')

if ! systemctl is-active --quiet bluetooth; then
    echo "󰂲"
    echo "󰂲"
    echo "#5C6370"
    exit
fi

if [[ -z "$devices" ]]; then
    echo "󰂯"
    echo "󰂯"
    echo "#5C6370"
    exit
fi

output=""
icons=""

for device in $devices; do
    info=$(bluetoothctl info "$device")

    name=$(echo "$info" | grep "Name" | awk -F': ' '{print $2}')
    type=$(echo "$info" | grep "Icon" | awk -F': ' '{print $2}')

    case "$type" in
        input-mouse)
            icon="󰍽" ;;
        input-keyboard)
            icon="󰌌" ;;
        audio-headphones|audio-headset)
            icon="󰋋" ;;
        phone)
            icon="󰄜" ;;
        *)
            icon="󰂯" ;;
    esac

    output+="$icon $name "
    icons+="$icon "
done

if [[ "$BAR_ROLE" == "main" ]]; then
    echo ${output%?}
    echo ${output%?}
    echo "#3B99FC"
else
    echo ${icons%?}
    echo ${icons%?}
    echo "#3B99FC"
fi
