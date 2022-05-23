#!/usr/bin/env bash

export DISPLAY=:0

# Start virtual frame buffer (if it is not already running)
if ! pgrep -x "Xvfb" > /dev/null; then
    sudo Xvfb -screen 0 640x480x16 > /dev/null & \
    sleep 2
fi

# Run wine with Xvfb as the display, passing along all command-line parameters
DISPLAY=:0 wine "$@"