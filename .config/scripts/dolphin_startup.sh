#!/bin/bash
sleep 6
hyprctl dispatch workspace 3
sleep 0.3
dolphin &

# Wait up to 5 seconds for Dolphin window to appear
timeout=50
while (( timeout > 0 )); do
    # Check if any window with class 'org.kde.dolphin' exists
    if hyprctl clients | grep -q "org.kde.dolphin"; then
        break
    fi
    sleep 0.1
    ((timeout--))
done

hyprctl dispatch workspace 5
