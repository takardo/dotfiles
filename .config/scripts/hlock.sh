#!/bin/bash

#sleep before screenshot
sleep 1;

#Take a screenshot
grim -o DP-1 /tmp/lockscreen.png;

#lock the screen
hyprlock;
