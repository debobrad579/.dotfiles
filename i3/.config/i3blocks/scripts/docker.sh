#!/usr/bin/env bash

count=$(docker ps -q 2>/dev/null | wc -l)

[[ "$count" -eq 0 ]] && exit

echo "  $count"
