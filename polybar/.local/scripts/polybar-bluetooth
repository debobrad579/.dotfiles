#!/usr/bin/env bash

render() {
    if ! systemctl is-active --quiet bluetooth; then
        echo "%{F#5C6370}󰂲%{F-}"
        return
    fi

    icons=""

    while IFS= read -r path; do
        connected=$(busctl get-property org.bluez "$path" org.bluez.Device1 Connected 2>/dev/null | awk '{print $2}')
        [[ "$connected" != "true" ]] && continue

        icon_type=$(busctl get-property org.bluez "$path" org.bluez.Device1 Icon 2>/dev/null | awk -F'"' '{print $2}')

        case "$icon_type" in
            input-mouse)             icon="󰍽" ;;
            input-keyboard)          icon="󰌌" ;;
            audio-headphones|audio-headset) icon="󰋋" ;;
            phone)                   icon="󰄜" ;;
            *)                       icon="󰂯" ;;
        esac

        icons+="$icon "
    done < <(busctl tree org.bluez 2>/dev/null | grep -oP '/org/bluez/hci\d+/dev_\S+' | sort -u)

    if [[ -z "$icons" ]]; then
        echo "%{F#5C6370}󰂯%{F-}"
    else
        echo "%{F#0082FC}${icons% }%{F-}"
    fi
}

render

bluetoothctl --monitor | while read -r line; do
    render
done
