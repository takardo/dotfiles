#!/bin/bash

# Apply the colors to active and inactive borders
hyprctl keyword general:col.active_border \
    0xffFF0000 0xffFF7F00 0xffFFFF00 0xff00FF00 0xff0000FF \
    0xff4B0082 0xff8B00FF 0xffFF1493 0xffFF6347 0xff00CED1 \
    270deg

hyprctl keyword general:col.inactive_border \
    0xffFF0000 0xffFF7F00 0xffFFFF00 0xff00FF00 0xff0000FF \
    0xff4B0082 0xff8B00FF 0xffFF1493 0xffFF6347 0xff00CED1 \
    270deg
