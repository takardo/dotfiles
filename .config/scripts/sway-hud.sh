#!/bin/bash

kitty --title="nvtop" -e nvtop &
kitty --title="btop" -e btop &
kitty --title="cava" -e cava &
kitty --title="tty" -e /home/tumbleweed/dotfiles/.config/scripts/tty.sh &

wait_for_window() {
  local title="$1"
  while ! swaymsg -t get_tree | jq -e --arg title "$title" \
    '.. | select(.name == $title)' > /dev/null; do
    sleep 0.1
  done
  # Longer wait for window to be fully ready
  sleep 2
}

resize_window() {
  local title="$1"
  local width="$2"
  local height="$3"
  for i in {1..5}; do
    swaymsg "[title=\"$title\"] resize set width $width px height $height px"
    sleep 0.1
  done
}

for title in \
  "GigaChad Theme (Phonk House Version) - YouTube Music" \
  "nvtop" "tty" "btop" "cava"
do
  wait_for_window "$title"
  swaymsg "[title=\"$title\"] floating enable"
done

# Move windows
swaymsg '[title="GigaChad Theme (Phonk House Version) - YouTube Music"] move position 5 -484'
swaymsg '[title="nvtop"] move position 483 -484'
swaymsg '[title="tty"] move position 5 206'
swaymsg '[title="btop"] move position 5 433'
swaymsg '[title="cava"] move position 5 1086'

# Resize windows (with retries)
resize_window "nvtop" 633 638
resize_window "btop" 1070 729
resize_window "cava" 1071 260
resize_window "tty" 1070 230
resize_window "GigaChad Theme (Phonk House Version) - YouTube Music" 434 640
