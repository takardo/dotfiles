#!/bin/bash

start=$(date +%s%3N)  # Get the start time in milliseconds

while true; do
    now=$(date +%s%3N)  # Get the current time in milliseconds
    elapsed=$((now - start))  # Calculate the elapsed time in milliseconds

    # Calculate hours, minutes, seconds, and milliseconds
    hours=$((elapsed / 3600000))
    minutes=$(( (elapsed % 3600000) / 60000 ))
    seconds=$(( (elapsed % 60000) / 1000 ))
    milliseconds=$((elapsed % 1000))

    # Clear the screen and display the elapsed time with figlet
    clear
    printf "Time:\n"
    printf "%02d:%02d:%02d.%03d\n" $hours $minutes $seconds $milliseconds

    # Sleep for 0.1 seconds to update the display
    sleep 0.1
done
