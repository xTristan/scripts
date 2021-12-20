#!/bin/bash

# toggles the external monitor on/off in specified direction
VERTICAL="HDMI-0"
HORIZONTAL="DP-0"
DIRECTION="right-of"

xrandr --output $VERTICAL --mode 2560x1440 --rotate left
xrandr --output $HORIZONTAL --primary --scale 1x1 --mode 3440x1440 --$DIRECTION $VERTICAL
