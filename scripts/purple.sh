#!/bin/bash

# Apply the colors to active and inactive borders with a purple, pink, and blue palette
hyprctl keyword general:col.active_border \
    0xff9B4DFF 0xffFF69B4 0xff8A2BE2 0xff00BFFF 0xffDA70D6 0xffBA55D3 0xff9400D3 0xffFF1493 0xff1E90FF 0xff8A2BE2 270deg

hyprctl keyword general:col.inactive_border \
    0xff9B4DFF 0xffFF69B4 0xff8A2BE2 0xff00BFFF 0xffDA70D6 0xffBA55D3 0xff9400D3 0xffFF1493 0xff1E90FF 0xff8A2BE2 270deg
