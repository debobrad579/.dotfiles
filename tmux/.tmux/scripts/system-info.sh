#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
memory_usage=$(free -m | awk '/^Mem:/ {printf "%.1fGB/%.1fGB", $3/1024, $2/1024}')

echo "  ${cpu_usage}% |   ${memory_usage}"
