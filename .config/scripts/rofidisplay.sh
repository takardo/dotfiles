#!/bin/bash

CONFIG="$HOME/dotfiles/.config/hypr/hyprland.conf"
STATE_FILE="$HOME/dotfiles/.config/scripts/hypr_monitor_state"

MODES=(
    "640x480@59.94"
    "800x600@60.32"
    "1024x768@60.00"
    "1024x768@70.07"
    "1024x768@75.03"
    "1400x1050@59.98"
    "1600x1200@60.00"
    "1920x1080@59.94"
)

declare -A monitor_states

[[ -f "$STATE_FILE" ]] && while IFS='=' read -r k v; do monitor_states["$k"]="$v"; done < "$STATE_FILE"

[[ -z "${monitor_states["DP-1"]}" ]] && \
    grep -q '^\s*monitor = DP-1, 1920x1080@179.98, 1080x0, 1' "$CONFIG" && \
    monitor_states["DP-1"]="enabled" || monitor_states["DP-1"]="disabled"

write_state() {
    for k in "${!monitor_states[@]}"; do
        echo "$k=${monitor_states[$k]}"
    done > "$STATE_FILE"
}

toggle_dp1() {
    if [[ ${monitor_states["DP-1"]} == "enabled" ]]; then
        sed -i 's|^\s*monitor = DP-1,.*|#&|' "$CONFIG"
        sed -i 's|^\s*#\s*monitor = DP-1, disable|monitor = DP-1, disable|' "$CONFIG"
        monitor_states["DP-1"]="disabled"
    else
        sed -i 's|^\s*#\s*monitor = DP-1, 1920x1080@179.98, 1080x0, 1|monitor = DP-1, 1920x1080@179.98, 1080x0, 1|' "$CONFIG"
        sed -i 's|^\s*monitor = DP-1, disable|#monitor = DP-1, disable|' "$CONFIG"
        monitor_states["DP-1"]="enabled"
    fi
    write_state
    hyprctl reload &>/dev/null
    sleep 1
    waypaper --restore &>/dev/null
}

toggle_dp2() {
    if [[ ${monitor_states["DP-2"]} == "enabled" ]]; then
        sed -i 's|^\s*monitor = DP-2,.*|#&|' "$CONFIG"
        sed -i 's|^\s*#\s*monitor = DP-2, disable|monitor = DP-2, disable|' "$CONFIG"
        monitor_states["DP-2"]="disabled"
    else
        sed -i 's|^\s*#\s*monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3|monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3|' "$CONFIG"
        sed -i 's|^\s*monitor = DP-2, disable|#monitor = DP-2, disable|' "$CONFIG"
        monitor_states["DP-2"]="enabled"
    fi
    write_state
    hyprctl reload &>/dev/null
    sleep 1
    waypaper --restore &>/dev/null
}

toggle_dp3() {
    if [[ ${monitor_states["DP-3"]} == "enabled" ]]; then
        sed -i 's|^\s*monitor = DP-3,.*|#&|' "$CONFIG"
        sed -i 's|^\s*#\s*monitor = DP-3, disable|monitor = DP-3, disable|' "$CONFIG"
        monitor_states["DP-3"]="disabled"
    else
        sed -i 's|^\s*#\s*monitor = DP-3, 1920x1080@60.00, 3000x-515, 1, transform, 1|monitor = DP-3, 1920x1080@60.00, 3000x-515, 1, transform, 1|' "$CONFIG"
        sed -i 's|^\s*monitor = DP-3, disable|#monitor = DP-3, disable|' "$CONFIG"
        monitor_states["DP-3"]="enabled"
    fi
    write_state
    hyprctl reload &>/dev/null
    sleep 1
    waypaper --restore &>/dev/null
}

toggle_hdmi() {
    if [[ ${monitor_states["HDMI-A-1"]} == "enabled" ]]; then
        for m in "${MODES[@]}"; do
            sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
        done
        sed -i 's|^\s*#\s*monitor = HDMI-A-1, disable|monitor = HDMI-A-1, disable|' "$CONFIG"
        monitor_states["HDMI-A-1"]="disabled"
    else
        sed -i 's|^\s*monitor = HDMI-A-1, disable|#monitor = HDMI-A-1, disable|' "$CONFIG"
        local mode="${monitor_states["HDMI-A-1_MODE"]:-640x480@59.94}"
        for m in "${MODES[@]}"; do
            sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
        done
        sed -i "s|^\s*#monitor = HDMI-A-1, $mode, 4080x480, 1|monitor = HDMI-A-1, $mode, 4080x480, 1|" "$CONFIG"
        monitor_states["HDMI-A-1"]="enabled"
        monitor_states["HDMI-A-1_MODE"]="$mode"
    fi
    write_state
    hyprctl reload &>/dev/null
    sleep 1
    waypaper --restore &>/dev/null
}

disable_all_except_dp1() {
    sed -i 's|^\s*monitor = DP-2,.*|#&|' "$CONFIG"
    sed -i 's|^\s*#\s*monitor = DP-2, disable|monitor = DP-2, disable|' "$CONFIG"
    sed -i 's|^\s*monitor = DP-3,.*|#&|' "$CONFIG"
    sed -i 's|^\s*#\s*monitor = DP-3, disable|monitor = DP-3, disable|' "$CONFIG"
    for m in "${MODES[@]}"; do
        sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
    done
    sed -i 's|^\s*#\s*monitor = HDMI-A-1, disable|monitor = HDMI-A-1, disable|' "$CONFIG"
    monitor_states["DP-2"]="disabled"
    monitor_states["DP-3"]="disabled"
    monitor_states["HDMI-A-1"]="disabled"
    write_state
    hyprctl reload &>/dev/null
    sleep 1
}

enable_all_monitors() {
    sed -i 's|^\s*#\s*monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3|monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3|' "$CONFIG"
    sed -i 's|^\s*monitor = DP-2, disable|#monitor = DP-2, disable|' "$CONFIG"
    sed -i 's|^\s*#\s*monitor = DP-3, 1920x1080@60.00, 3000x-515, 1, transform, 1|monitor = DP-3, 1920x1080@60.00, 3000x-515, 1, transform, 1|' "$CONFIG"
    sed -i 's|^\s*monitor = DP-3, disable|#monitor = DP-3, disable|' "$CONFIG"
    local mode="${monitor_states["HDMI-A-1_MODE"]:-640x480@59.94}"
    sed -i 's|^\s*monitor = HDMI-A-1, disable|#monitor = HDMI-A-1, disable|' "$CONFIG"
    for m in "${MODES[@]}"; do
        sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
    done
    sed -i "s|^\s*#monitor = HDMI-A-1, $mode, 4080x480, 1|monitor = HDMI-A-1, $mode, 4080x480, 1|" "$CONFIG"
    monitor_states["DP-2"]="enabled"
    monitor_states["DP-3"]="enabled"
    monitor_states["HDMI-A-1"]="enabled"
    monitor_states["HDMI-A-1_MODE"]="$mode"
    write_state
    hyprctl reload &>/dev/null
    sleep 1
    waypaper --restore &>/dev/null
}

while true; do
    OPTIONS=$(
        printf "%s\n" \
        "📺 Set HDMI-A-1 Resolution" \
        "📺 Toggle HDMI-A-1 (${monitor_states["HDMI-A-1"]:-unknown})" \
        "🖥️ Toggle DP-1 (${monitor_states["DP-1"]:-unknown})" \
        "🖥️ Toggle DP-2 (${monitor_states["DP-2"]:-unknown})" \
        "🖥️ Toggle DP-3 (${monitor_states["DP-3"]:-unknown})" \
        "⛔ Disable all except DP-1" \
        "✅ Enable all monitors" \
        "🚪 Exit"
    )
    CHOICE=$(echo "$OPTIONS" | rofi -dmenu -config /home/tumbleweed/dotfiles/.config/rofi/rofidisplay/config.rasi -p "Hyprland Display Manager")

    # Exit if ESC or no input
    if [[ -z "$CHOICE" ]]; then
        exit 0
    fi

    case "$CHOICE" in
        "📺 Set HDMI-A-1 Resolution")
            SELECTED=$(printf "%s\n" "${MODES[@]}" | rofi -dmenu -config /home/tumbleweed/dotfiles/.config/rofi/rofidisplay/config.rasi -p "HDMI-A-1 Resolution")

            # Exit if ESC or no input in resolution menu
            if [[ -z "$SELECTED" ]]; then
                exit 0
            fi

            sed -i 's|^\s*monitor = HDMI-A-1, disable|#monitor = HDMI-A-1, disable|' "$CONFIG"
            for m in "${MODES[@]}"; do
                sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
            done
            sed -i "s|^\s*#monitor = HDMI-A-1, $SELECTED, 4080x480, 1|monitor = HDMI-A-1, $SELECTED, 4080x480, 1|" "$CONFIG"
            monitor_states["HDMI-A-1"]="enabled"
            monitor_states["HDMI-A-1_MODE"]="$SELECTED"
            write_state
            hyprctl reload &>/dev/null
            sleep 1
            waypaper --restore &>/dev/null
            ;;
        "📺 Toggle HDMI-A-1 ("*)
            toggle_hdmi ;;
        "🖥️ Toggle DP-1 ("*)
            toggle_dp1 ;;
        "🖥️ Toggle DP-2 ("*)
            toggle_dp2 ;;
        "🖥️ Toggle DP-3 ("*)
            toggle_dp3 ;;
        "⛔ Disable all except DP-1")
            disable_all_except_dp1 ;;
        "✅ Enable all monitors")
            enable_all_monitors ;;
        "🚪 Exit")
            exit 0 ;;
    esac
done
