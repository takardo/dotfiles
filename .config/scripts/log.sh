#!/bin/bash
RAWLOG="$HOME/terminal.rawlog"
CLEANLOG="$HOME/terminal.txt"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Start logging terminal session quietly to raw log file
script -aq "$RAWLOG"

# Append a visual separator and timestamp before new log content
{
  echo -e "\n\n===== LOG START: $TIMESTAMP =====\n"
  ansifilter -i "$RAWLOG"
  echo -e "\n===== LOG END: $TIMESTAMP =====\n"
} >> "$CLEANLOG"

# Remove the raw log file since it's no longer needed
rm "$RAWLOG"
