#!/bin/bash

HISTORY_FILE="/home/tumbleweed/swaybg_history.txt"
LAST_WALLPAPER=""

while true; do
    # Use pgrep with -a for full command line, avoids grep overhead
    CURRENT_WALLPAPER=$(pgrep -a swaybg | awk -F '-i ' '{print $2}' | awk '{print $1}')

    if [[ -n "$CURRENT_WALLPAPER" && "$CURRENT_WALLPAPER" != "$LAST_WALLPAPER" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $CURRENT_WALLPAPER" >> "$HISTORY_FILE"
        LAST_WALLPAPER="$CURRENT_WALLPAPER"
    fi

    sleep 30  # Increase to 30 seconds for less frequent checks
done
