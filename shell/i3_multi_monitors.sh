#!/bin/bash

# toggles the external monitor on/off in specified direction
INTERNAL="eDP-1"
EXTERNAL="DP-1-2"
DIRECTION="above"

if (xrandr | grep "$EXTERNAL connected"); then
    xrandr --output $INTERNAL --mode 2560x1440
    xrandr --output $EXTERNAL --primary --scale 1x1 --mode 3440x1440 --$DIRECTION $INTERNAL
else
    xrandr --output $INTERNAL --mode 2560x1440
    xrandr --output $EXTERNAL --off 
fi
