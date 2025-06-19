#!/bin/bash

colors=(
  "244;184;228" # #f4b8e4 (Pink)
  "202;158;230" # #ca9ee6 (Purple)
  "231;130;132" # #e78284 (Red)
  "239;159;118" # #ef9f76 (Orange)
  "229;200;144" # #e5c890 (Yellow)
  "166;209;137" # #a6d189 (Green)
  "150;205;251" # #96CDFB (Blue)
)
invader=(
"  ▀▄   ▄▀  "
" ▄█▀███▀█▄ "
"█▀███████▀█"
"█ █▀▀▀▀▀█ █"
"   ▀▀ ▀▀   "
)

print_invaders_side_by_side() {
  # For each line of the invader
  for i in ${!invader[@]}; do
    # For each color, print the invader on the same line
    for color in "${colors[@]}"; do
      printf "\033[38;2;%sm%s  \033[0m" "$color" "${invader[$i]}"
    done
    # Move to the next line after all invaders for the current line are printed
    printf "\n"
  done
}

print_invaders_side_by_side
