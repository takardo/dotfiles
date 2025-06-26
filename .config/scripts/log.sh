#!/bin/bash

# This will log your terminal output and run it through ansi filter.

#Make sure to Ctrl+D or type exit before closing terminal or it won't format with ansifilter.

RAWLOG="$HOME/terminal.rawlog"
CLEANLOG="$HOME/terminal.txt"

# Start logging terminal session quietly to raw log file
script -aq "$RAWLOG"

# Convert raw log to clean text by removing ANSI escape sequences
ansifilter -i "$RAWLOG" -o "$CLEANLOG"

# Remove the raw log file since it's no longer needed
rm "$RAWLOG"

