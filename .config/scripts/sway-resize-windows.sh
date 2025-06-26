#!/bin/bash

for i in {1..10}; do
  swaymsg '[title="nvtop"] floating enable'
  swaymsg '[title="nvtop"] resize set width 626 px height 636 px'

  swaymsg '[title="btop"] floating enable'
  swaymsg '[title="btop"] resize set width 1062 px height 729 px'

  swaymsg '[title="cava"] floating enable'
  swaymsg '[title="cava"] resize set width 1062 px height 259 px'

  swaymsg '[title="tty"] floating enable'
  swaymsg '[title="tty"] resize set width 1062 px height 227 px'

  swaymsg '[title="YouTube Music"] floating enable'
  swaymsg '[title="YouTube Music"] resize set width 427 px height 636 px'


  sleep 0.3
done
