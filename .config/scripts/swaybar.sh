#!/bin/bash

pkill waybar;

waybar -c /home/tumbleweed/dotfiles/.config/waybar/sway-default/config -s /home/tumbleweed/dotfiles/.config/waybar/sway-default/style.css & disown;


