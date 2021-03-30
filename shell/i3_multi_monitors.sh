#!/bin/bash

# toggles the external monitor on/off in specified direction
INTERNAL="eDP1"
EXTERNAL_DELL="DP1"
EXTERNAL_OTHER="HDMI-1"
DIRECTION="above"

if (xrandr | grep " $EXTERNAL_DELL connected"); then
   xrandr --output $INTERNAL --scale 1x1 --mode 2560x1440
   xrandr --output $EXTERNAL_DELL --primary --scale 1.5x1.5 --mode 3440x1440 --$DIRECTION $INTERNAL
elif (xrandr | grep " $EXTERNAL_OTHER connected"); then
   xrandr --output $INTERNAL --scale 1x1 --mode 2560x1440
   xrandr --output $EXTERNAL_OTHER --primary --scale 1x1 --mode 2560x1440 --$DIRECTION $INTERNAL
else
    xrandr --output $INTERNAL --primary --scale 0.9x0.9 --mode 2560x1440
    xrandr --output $EXTERNAL_DELL --off 
    xrandr --output $EXTERNAL_OTHER --off 
fi
