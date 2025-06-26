#!/bin/bash

OUTPUT="HDMI-A-1"
RESOLUTION="640x480"
POSITION="3000 180"
SCALE="1"

CURRENT_STATE=$(swaymsg -t get_outputs | jq -r ".[] | select(.name==\"$OUTPUT\") | .active")

if [[ "$CURRENT_STATE" == "true" ]]; then
    # Disable the output
    swaymsg output "$OUTPUT" disable
else
    # Enable the output with resolution, position, and scale
    swaymsg output "$OUTPUT" enable resolution "$RESOLUTION" position $POSITION scale $SCALE
fi
