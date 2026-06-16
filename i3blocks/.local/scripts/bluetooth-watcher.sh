#!/bin/bash

dbus-monitor --system "type='signal',sender='org.bluez',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" |
while read -r line; do
    if echo "$line" | grep -q 'boolean true\|boolean false'; then
        pkill -SIGRTMIN+2 i3blocks 
    fi
done
