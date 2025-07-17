#!/bin/bash

HISTORY_FILE="$HOME/hyprpaper_history.txt"
LAST_HASH=""

# If history file exists, try to extract the last hash
if [[ -f "$HISTORY_FILE" ]]; then
    LAST_HASH=$(tac "$HISTORY_FILE" | grep -m1 -oP '^[a-f0-9]{32}')
fi

# Wait a bit to ensure Hyprpaper is fully initialized
sleep 5

while true; do
    CURRENT_WALLPAPERS=$(hyprctl hyprpaper listactive | sort)
    CURRENT_HASH=$(echo "$CURRENT_WALLPAPERS" | md5sum | awk '{print $1}')

    if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
        {
            echo "$CURRENT_HASH"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Wallpapers changed:"
            echo "$CURRENT_WALLPAPERS"
            echo
        } >> "$HISTORY_FILE"

        LAST_HASH="$CURRENT_HASH"
    fi

    sleep 30
done
