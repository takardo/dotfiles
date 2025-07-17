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

# Load state file if exists
if [[ -f "$STATE_FILE" ]]; then
    while IFS='=' read -r key value; do
        monitor_states["$key"]="$value"
    done < "$STATE_FILE"
fi

write_state() {
    {
        for key in "${!monitor_states[@]}"; do
            echo "$key=${monitor_states[$key]}"
        done
    } > "$STATE_FILE"
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
    # No waypaper restore here on disable
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

# Main interactive loop with gum menu

while true; do
    CHOICE=$(gum choose --cursor.foreground="#00FF00" --header="Hyprland Monitor Manager - Choose an option" \
        "Set HDMI-A-1 Resolution" \
        "Toggle HDMI-A-1 (${monitor_states["HDMI-A-1"]:-unknown})" \
        "Toggle DP-2 (${monitor_states["DP-2"]:-unknown})" \
        "Toggle DP-3 (${monitor_states["DP-3"]:-unknown})" \
        "Disable all except DP-1" \
        "Enable all monitors" \
        "Exit")

    case $CHOICE in
        "Set HDMI-A-1 Resolution")
            MODE=$(gum choose --cursor.foreground="#00FFFF" --header="Select HDMI-A-1 resolution" "${MODES[@]}")
            if [[ -n "$MODE" ]]; then
                sed -i 's|^\s*monitor = HDMI-A-1, disable|#monitor = HDMI-A-1, disable|' "$CONFIG"
                for m in "${MODES[@]}"; do
                    sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
                done
                sed -i "s|^\s*#monitor = HDMI-A-1, $MODE, 4080x480, 1|monitor = HDMI-A-1, $MODE, 4080x480, 1|" "$CONFIG"
                monitor_states["HDMI-A-1"]="enabled"
                monitor_states["HDMI-A-1_MODE"]="$MODE"
                write_state
                hyprctl reload &>/dev/null
                sleep 1
                waypaper --restore &>/dev/null
                gum spin --spinner dot --title "HDMI-A-1 enabled with mode $MODE" -- sleep 1
            fi
            ;;
        "Toggle HDMI-A-1 (${monitor_states["HDMI-A-1"]:-unknown})")
            toggle_hdmi
            gum spin --spinner dot --title "Toggled HDMI-A-1" -- sleep 1
            ;;
        "Toggle DP-2 (${monitor_states["DP-2"]:-unknown})")
            toggle_dp2
            gum spin --spinner dot --title "Toggled DP-2" -- sleep 1
            ;;
        "Toggle DP-3 (${monitor_states["DP-3"]:-unknown})")
            toggle_dp3
            gum spin --spinner dot --title "Toggled DP-3" -- sleep 1
            ;;
        "Disable all except DP-1")
            disable_all_except_dp1
            gum spin --spinner dot --title "Disabled all except DP-1" -- sleep 1
            ;;
        "Enable all monitors")
            enable_all_monitors
            gum spin --spinner dot --title "Enabled all monitors" -- sleep 1
            ;;
        "Exit")
            echo "Exiting..."
            exit 0
            ;;
    esac
done
