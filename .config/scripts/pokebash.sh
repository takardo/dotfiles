#!/bin/bash
IMAGE_DIR=/home/tumbleweed/gen1png
RANDOM_IMAGE=$(ls "$IMAGE_DIR"/*.png | shuf -n 1)
viu -x 10 -w 13 "$RANDOM_IMAGE"
