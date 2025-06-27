#!/bin/bash

CONF="$HOME/dotfiles3/.config/hypr/hyprland.conf"
DATE_TAG="# Last updated on"
TODAY=$(date '+%Y-%m-%d %H:%M:%S')

if grep -q "^$DATE_TAG" "$CONF"; then
    # Replace existing date
    sed -i "s|^$DATE_TAG .*|$DATE_TAG $TODAY|" "$CONF"
else
    # Insert at top
    sed -i "1i$DATE_TAG $TODAY" "$CONF"
fi
