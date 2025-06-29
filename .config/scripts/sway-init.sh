#!/bin/bash

# Wait for DP-2 monitor to be available
while ! swaymsg -t get_outputs | grep -q '"name": "DP-2"'; do
  sleep 0.5
done

sleep 1  # Let workspace assignments stabilize

# Force workspace 9 to DP-2
swaymsg workspace 9
swaymsg move workspace to output DP-2

# Move other windows to workspace 9
swaymsg '[title="nvtop"] move to workspace 9'
swaymsg '[title="tty-clock"] move to workspace 9'
swaymsg '[title="btop"] move to workspace 9'
swaymsg '[title="cava"] move to workspace 9'

# Enable floating for these windows
swaymsg '[title="nvtop"] floating enable'
swaymsg '[title="tty-clock"] floating enable'
swaymsg '[title="btop"] floating enable'
swaymsg '[title="cava"] floating enable'

# Resize them
swaymsg '[title="nvtop"] resize set width 626 px height 636 px'
swaymsg '[title="btop"] resize set width 1062 px height 729 px'
swaymsg '[title="cava"] resize set width 1062 px height 259 px'
swaymsg '[title="tty-clock"] resize set width 1062 px height 227 px'

# Position these windows
swaymsg '[title="nvtop"] move position 435 -1'
swaymsg '[title="tty-clock"] move position -1 645'
swaymsg '[title="btop"] move position -1 880'
swaymsg '[title="cava"] move position -1 1618'

# Wait 2 seconds for YouTube Music to launch
sleep 2

# Handle YouTube Music separately using class matcher
swaymsg '[class="com.github.th_ch.youtube_music"] move to workspace 9'
swaymsg '[class="com.github.th_ch.youtube_music"] floating enable'
swaymsg '[class="com.github.th_ch.youtube_music"] resize set width 427 px height 636 px'
swaymsg '[class="com.github.th_ch.youtube_music"] move position 0 -1'
