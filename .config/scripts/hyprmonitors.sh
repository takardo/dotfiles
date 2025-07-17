#!/bin/bash

CONFIG="$HOME/dotfiles/.config/hypr/hyprland.conf"
STATE_FILE="/home/tumbleweed/dotfiles/.config/scripts/hypr_monitor_state"

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

# === STATE LOADING ===
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

# === TOGGLES ===

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
}

# === MENU ===

echo "Select an option:"
for i in "${!MODES[@]}"; do
    printf " %d) Set HDMI-A-1 with %s\n" $((i+1)) "${MODES[i]}"
done
echo " 9) Toggle HDMI-A-1 (${monitor_states["HDMI-A-1"]:-unknown})"
echo "10) Toggle DP-2 (${monitor_states["DP-2"]:-unknown})"
echo "11) Toggle DP-3 (${monitor_states["DP-3"]:-unknown})"
echo "12) Disable all except DP-1"
echo "13) Enable all monitors"
echo " 0) Exit"

read -rp "Enter choice [0-13]: " choice

case $choice in
    [1-8])
        selected_mode="${MODES[choice-1]}"
        sed -i 's|^\s*monitor = HDMI-A-1, disable|#monitor = HDMI-A-1, disable|' "$CONFIG"
        for m in "${MODES[@]}"; do
            sed -i "s|^\s*monitor = HDMI-A-1, $m, 4080x480, 1|#monitor = HDMI-A-1, $m, 4080x480, 1|" "$CONFIG"
        done
        sed -i "s|^\s*#monitor = HDMI-A-1, $selected_mode, 4080x480, 1|monitor = HDMI-A-1, $selected_mode, 4080x480, 1|" "$CONFIG"
        monitor_states["HDMI-A-1"]="enabled"
        monitor_states["HDMI-A-1_MODE"]="$selected_mode"
        write_state
        hyprctl reload
        echo "HDMI-A-1 enabled with mode $selected_mode."
        ;;
    9)
        toggle_hdmi && hyprctl reload
        ;;
    10)
        toggle_dp2 && hyprctl reload
        ;;
    11)
        toggle_dp3 && hyprctl reload
        ;;
    12)
        disable_all_except_dp1 && hyprctl reload
        ;;
    13)
        enable_all_monitors && hyprctl reload
        ;;
    0)
        echo "Exiting." && exit 0
        ;;
    *)
        echo "Invalid choice." && exit 1
        ;;
esac
