#!/bin/bash

CONFIG="$HOME/dotfiles/.config/hypr/hyprland.conf"
STATE_FILE="/tmp/hypr_monitor_state"

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

dp2_enabled=false
dp3_enabled=false

# Load saved state if exists
if [[ -f "$STATE_FILE" ]]; then
    monitor_state=$(sed -n '1p' "$STATE_FILE")
    saved_dp3_mode=$(sed -n '2p' "$STATE_FILE")
else
    monitor_state="unknown"
    saved_dp3_mode=""
fi

check_monitors_state() {
    dp2_enabled=false
    dp3_enabled=false

    if grep -qE '^\s*monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3,' "$CONFIG"; then
        dp2_enabled=true
    fi

    for mode in "${MODES[@]}"; do
        if grep -qE "^\s*monitor = DP-3, $mode, 3000x180, 1" "$CONFIG"; then
            dp3_enabled=true
            break
        fi
    done
}

disable_monitors() {
    sed -i 's|^\s*monitor = DP-2,.*|#&|' "$CONFIG"
    sed -i 's|^\s*monitor = DP-3,.*|#&|' "$CONFIG"
    sed -i 's|^\s*#\s*monitor = DP-2, disable|monitor = DP-2, disable|' "$CONFIG"
    sed -i 's|^\s*#\s*monitor = DP-3, disable|monitor = DP-3, disable|' "$CONFIG"
    echo "disabled" > "$STATE_FILE"
    echo "" >> "$STATE_FILE"
    hyprctl reload
    echo "DP-2 and DP-3 monitors disabled"
}

enable_monitors_with_mode() {
    local mode="$1"
    sed -i 's|^\s*#\s*monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3,|monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3,|' "$CONFIG"
    sed -i 's|^\s*monitor = DP-2, disable|#monitor = DP-2, disable|' "$CONFIG"
    sed -i 's|^\s*monitor = DP-3, disable|#monitor = DP-3, disable|' "$CONFIG"
    # Comment out all DP-3 modes first
    for m in "${MODES[@]}"; do
        sed -i "s|^\s*monitor = DP-3, $m, 3000x180, 1|#monitor = DP-3, $m, 3000x180, 1|" "$CONFIG"
    done
    # Uncomment chosen DP-3 mode
    sed -i "s|^\s*#monitor = DP-3, $mode, 3000x180, 1|monitor = DP-3, $mode, 3000x180, 1|" "$CONFIG"
    echo "enabled" > "$STATE_FILE"
    echo "$mode" >> "$STATE_FILE"
    hyprctl reload
    echo "Monitors enabled with DP-3 mode $mode"
}

toggle_dp3() {
    for m in "${MODES[@]}"; do
        if grep -qE "^\s*monitor = DP-3, $m, 3000x180, 1" "$CONFIG"; then
            echo "Disabling DP-3 monitor..."
            sed -i "s|^\s*monitor = DP-3, $m, 3000x180, 1|#monitor = DP-3, $m, 3000x180, 1|" "$CONFIG"
            sed -i "s|^\s*#\s*monitor = DP-3, disable|monitor = DP-3, disable|" "$CONFIG"
            echo "disabled" > "$STATE_FILE"
            echo "" >> "$STATE_FILE"
            hyprctl reload
            echo "DP-3 toggled off."
            return
        fi
    done
    echo "Enabling DP-3 monitor with default mode 640x480@59.94..."
    sed -i "s|^\s*monitor = DP-3, disable|#monitor = DP-3, disable|" "$CONFIG"
    sed -i "s|^\s*#\s*monitor = DP-3, 640x480@59.94, 3000x180, 1|monitor = DP-3, 640x480@59.94, 3000x180, 1|" "$CONFIG"
    echo "enabled" > "$STATE_FILE"
    echo "640x480@59.94" >> "$STATE_FILE"
    hyprctl reload
    echo "DP-3 toggled on."
}

# === MAIN ===

check_monitors_state

if $dp2_enabled && $dp3_enabled; then
    echo "Monitors DP-2 and DP-3 are enabled."
elif $dp2_enabled && ! $dp3_enabled; then
    echo "Monitor DP-2 is enabled; DP-3 is disabled."
elif ! $dp2_enabled && $dp3_enabled; then
    echo "Monitor DP-3 is enabled; DP-2 is disabled."
else
    echo "Monitors DP-2 and DP-3 are currently disabled."
fi

echo

if [[ "$monitor_state" == "enabled" ]]; then
    echo "Last saved DP-3 mode: ${saved_dp3_mode:-None}"
fi

echo

if $dp2_enabled && $dp3_enabled; then
    echo "Select DP-3 mode to enable or other options:"
    for i in "${!MODES[@]}"; do
        printf " %d) %s\n" $((i+1)) "${MODES[i]}"
    done
    toggle_index=$(( ${#MODES[@]} + 1 ))
    disable_index=$(( ${#MODES[@]} + 2 ))
    echo " $toggle_index) Toggle DP-3 enable/disable"
    echo " $disable_index) Disable both DP-2 and DP-3 monitors"
    echo " 0) Exit"

    read -rp "Enter choice [0-$disable_index]: " choice

    if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 0 || choice > disable_index )); then
        echo "Invalid choice."
        exit 1
    fi

    if (( choice == 0 )); then
        echo "Exiting."
        exit 0
    elif (( choice == toggle_index )); then
        toggle_dp3
    elif (( choice == disable_index )); then
        disable_monitors
    else
        selected_mode="${MODES[choice-1]}"
        enable_monitors_with_mode "$selected_mode"
    fi

elif $dp2_enabled && ! $dp3_enabled; then
    read -rp "Enable DP-3 and select mode? (y/N): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo -e "\nSelect DP-3 mode to enable:"
        for i in "${!MODES[@]}"; do
            printf " %d) %s\n" $((i+1)) "${MODES[i]}"
        done
        echo " 0) Exit"
        read -rp "Enter choice [0-${#MODES[@]}]: " choice
        if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 0 || choice > ${#MODES[@]} )); then
            echo "Invalid choice."
            exit 1
        fi
        if (( choice == 0 )); then
            echo "Exiting."
            exit 0
        fi
        selected_mode="${MODES[choice-1]}"
        enable_monitors_with_mode "$selected_mode"
    else
        echo "No changes made."
    fi

elif ! $dp2_enabled && $dp3_enabled; then
    read -rp "Enable DP-2? (y/N): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        sed -i 's|^\s*#\s*monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3,|monitor = DP-2, 1920x1080@60.00, 0x-515, 1, transform, 3,|' "$CONFIG"
        sed -i 's|^\s*monitor = DP-2, disable|#monitor = DP-2, disable|' "$CONFIG"
        echo "enabled" > "$STATE_FILE"
        echo "$saved_dp3_mode" >> "$STATE_FILE"
        hyprctl reload
        echo "DP-2 monitor enabled."
    else
        echo "No changes made."
    fi

else
    read -rp "Enable monitors and select DP-3 mode? (y/N): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo -e "\nSelect DP-3 mode to enable:"
        for i in "${!MODES[@]}"; do
            printf " %d) %s\n" $((i+1)) "${MODES[i]}"
        done
        echo " 0) Exit"
        read -rp "Enter choice [0-${#MODES[@]}]: " choice
        if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 0 || choice > ${#MODES[@]} )); then
            echo "Invalid choice."
            exit 1
        fi
        if (( choice == 0 )); then
            echo "Exiting."
            exit 0
        fi
        selected_mode="${MODES[choice-1]}"
        enable_monitors_with_mode "$selected_mode"
    else
        echo "No changes made."
    fi
fi
