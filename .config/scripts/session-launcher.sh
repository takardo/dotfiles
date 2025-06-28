#!/bin/bash

BLUE='\033[1;34m'
PINK='\033[1;35m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RESET='\033[0m'

session_names=("Hyprland" "Sway" "Plasma")
session_cmds=(
  "Hyprland -c /home/tumbleweed/dotfiles/.config/hypr/hyprland.conf"
  "sway -c /home/tumbleweed/dotfiles/.config/sway/config --unsupported-gpu"
  "dbus-run-session startplasma-wayland"
)
fonts=("whimsy" "small" "Fender")  # Assign a figlet font for each session

term_width=$(tput cols)

center_text() {
  local raw_text="$1"
  local text_no_color=$(echo -e "$raw_text" | sed 's/\x1B\[[0-9;]*[mK]//g')
  local padding=$(( (term_width - ${#text_no_color}) / 2 ))
  (( padding < 0 )) && padding=0
  # Use echo -e here so escape sequences are parsed correctly
  printf "%*s" $padding ""
  echo -e "$raw_text"
}

clear
echo -e "${BLUE}"
figlet -f 3d "Session Select" | while IFS= read -r line; do
  center_text "$line"
done
echo -e "${RESET}"

for i in "${!session_names[@]}"; do
  color=""
  case $i in
    0) color="$PINK" ;;
    1) color="$GREEN" ;;
    2) color="$ORANGE" ;;
  esac

  figlet_lines=()
  while IFS= read -r line; do
    figlet_lines+=("$line")
  done < <(figlet -f "${fonts[$i]}" "${session_names[$i]}")

  number="$((i + 1))) "
  number_width=${#number}

  echo -e "${color}"
  for j in "${!figlet_lines[@]}"; do
    if [[ $j -eq 0 ]]; then
      line="${number}${figlet_lines[$j]}"
    else
      line="$(printf '%*s' $number_width '')${figlet_lines[$j]}"
    fi
    center_text "$line"
  done
  echo -en "${RESET}"  # No newline to avoid spacing
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
  case $index in
    0) center_text "${PINK}Launching ${session_names[$index]}...${RESET}" ;;
    1) center_text "${GREEN}Launching ${session_names[$index]}...${RESET}" ;;
    2) center_text "${ORANGE}Launching ${session_names[$index]}...${RESET}" ;;
  esac
  exec ${session_cmds[$index]}
else
  center_text "Invalid choice."
  sleep 1
  exec "$0"
fi
