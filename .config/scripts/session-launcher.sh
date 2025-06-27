#!/bin/bash

BLUE='\033[1;34m'
RESET='\033[0m'

session_names=("Hyprland" "Sway" "Plasma")
session_cmds=(
  "Hyprland -c /home/tumbleweed/dotfiles/.config/hypr/hyprland.conf"
  "sway -c /home/tumbleweed/dotfiles/.config/sway/config --unsupported-gpu"
  "dbus-run-session startplasma-wayland"
)

term_width=$(tput cols)

center_text() {
  local text="$1"
  local padding=$(( (term_width - ${#text}) / 2 ))
  (( padding < 0 )) && padding=0
  printf "%*s%s\n" $padding "" "$text"
}

clear
echo -e "${BLUE}"
figlet -f 3d "Session Select" | while IFS= read -r line; do
  center_text "$line"
done
echo -e "${RESET}"

for i in "${!session_names[@]}"; do
  center_text "$((i + 1))) ${session_names[$i]}"
done
center_text "0) Exit"
echo

prompt="Choose session [0 to exit]: "
padding=$(( (term_width - ${#prompt}) / 2 ))
(( padding < 0 )) && padding=0
printf "%*s%s" $padding "" "$prompt"
read -r choice

if [[ "$choice" == "0" ]]; then
  center_text "Exiting..."
  exit 0
elif [[ "$choice" =~ ^[1-9][0-9]*$ && "$choice" -le "${#session_names[@]}" ]]; then
  index=$((choice - 1))
  center_text "Launching ${session_names[$index]}..."
  exec ${session_cmds[$index]}
else
  center_text "Invalid choice."
  sleep 1
  exec "$0"
fi
