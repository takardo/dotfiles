#!/bin/bash

CONFIG="/home/tumbleweed/dotfiles/.config/hypr/hyprland.conf"
ENABLED_LINE='monitor=HDMI-A-1, 640x480@59.94, 3000x180, 1'
DISABLED_LINE='monitor = HDMI-A-1, disable'

if grep -q "^[[:space:]]*${ENABLED_LINE}" "$CONFIG"; then
    # Disable HDMI
    sed -i "s|^[[:space:]]*${ENABLED_LINE}|        #${ENABLED_LINE}|" "$CONFIG"
    sed -i "s|^[[:space:]]*#\?[[:space:]]*${DISABLED_LINE}|        ${DISABLED_LINE}|" "$CONFIG"
elif grep -q "^[[:space:]]*${DISABLED_LINE}" "$CONFIG"; then
    # Enable HDMI
    sed -i "s|^[[:space:]]*${DISABLED_LINE}|        #${DISABLED_LINE}|" "$CONFIG"
    sed -i "s|^[[:space:]]*#\?[[:space:]]*${ENABLED_LINE}|        ${ENABLED_LINE}|" "$CONFIG"
else
    echo "Expected HDMI-A-1 config lines not found."
    exit 1
fi

hyprctl reload
