if [[ "$BAR_ROLE" == "main" ]]; then
    echo $(date +"%F %H:%M")
else
    echo $(date "+%H:%M")
fi
