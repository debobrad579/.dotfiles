#!/usr/bin/env bash

if ! systemctl is-active --quiet bluetooth; then
    echo "󰂲"; echo "󰂲"; echo "#5C6370"; exit
fi

output=""
icons=""

while IFS= read -r path; do
    connected=$(busctl get-property org.bluez "$path" org.bluez.Device1 Connected 2>/dev/null | awk '{print $2}')
    [[ "$connected" != "true" ]] && continue

    name=$(busctl get-property org.bluez "$path" org.bluez.Device1 Name 2>/dev/null | awk -F'"' '{print $2}')
    icon_type=$(busctl get-property org.bluez "$path" org.bluez.Device1 Icon 2>/dev/null | awk -F'"' '{print $2}')

    case "$icon_type" in
        input-mouse)             icon="󰍽" ;;
        input-keyboard)          icon="󰌌" ;;
        audio-headphones|audio-headset) icon="󰋋" ;;
        phone)                   icon="󰄜" ;;
        *)                       icon="󰂯" ;;
    esac

    output+="$icon $name "
    icons+="$icon "
done < <(busctl tree org.bluez 2>/dev/null | grep -oP '/org/bluez/hci\d+/dev_\S+' | sort -u)

if [[ -z "$output" ]]; then
    echo "󰂯"; echo "󰂯"; echo "#5C6370"; exit
fi

if [[ "$BAR_ROLE" == "main" ]]; then
    echo "${output%?}"; echo "${output%?}"; echo "#3B99FC"
else
    echo "${icons%?}"; echo "${icons%?}"; echo "#3B99FC"
fi
