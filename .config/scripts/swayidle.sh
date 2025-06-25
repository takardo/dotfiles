#!/bin/bash

swayidle -w \
  timeout 300 'hyprlock -c /home/tumbleweed/dotfiles/.config/hyprlock/sway/hyprlock.conf' \
  timeout 600 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep 'hyprlock -c /home/tumbleweed/dotfiles/.config/hyprlock/sway/hyprlock.conf'
