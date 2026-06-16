#!/usr/bin/env bash

mapfile -t ports < <(ss -ltnH | awk '{split($4,a,":"); port=a[length(a)]; if(port>=3000 && port<=8080) print port}')

current_port=""
icon=""
color=""

for port in "${ports[@]}"; do
    users=$(ss -ltnupH | grep ":$port " | sed -n 's/.*users:(("\([^"]*\)".*/\1/p' || true)
    
    [[ "$users" == *spotify* ]] && continue

    if [[ "$users" == *next-server* ]]; then
        icon=""
        color="#FFFFFF"
    elif [[ "$port" -eq 5173 ]]; then
        icon=""
        color="#646CFF"
    else
        icon="󰖟"
        color="#4FB6E6"
    fi

    current_port=$port
    break
done

[[ -z "$current_port" ]] && exit

case $BLOCK_BUTTON in
    1) xdg-open "http://localhost:$current_port" ;;
esac

echo "$icon $current_port"
echo "$icon"
echo "$color"
