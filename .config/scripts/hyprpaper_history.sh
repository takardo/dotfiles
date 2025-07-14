#!/bin/bash

HISTORY_FILE="$HOME/hyprpaper_history"
LAST_HASH=""

# Wait a bit to ensure Hyprpaper is fully initialized
sleep 5

while true; do
    CURRENT_WALLPAPERS=$(hyprctl hyprpaper listactive | sort)
    CURRENT_HASH=$(echo "$CURRENT_WALLPAPERS" | md5sum | awk '{print $1}')

    if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
        {
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Wallpapers changed:"
            echo "$CURRENT_WALLPAPERS"
            echo
        } >> "$HISTORY_FILE"

        LAST_HASH="$CURRENT_HASH"
    fi

    sleep 30
done
