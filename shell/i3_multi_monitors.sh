#!/bin/bash

# toggles the external monitor on/off in specified direction
INTERNAL="eDP-*1"
EXTERNAL_DELL="DP-*1"
EXTERNAL_OTHER="HDMI-*1"
DIRECTION="above"

if (xrandr | grep "^$EXTERNAL_DELL connected"); then
  echo "$EXTERNAL_DELL connected."
  echo "Setting up primiary to 2560x1440 with no scaling (small font)."
  xrandr --output $INTERNAL --scale 1x1 --mode 2560x1440
  echo "Setting external_dell $EXTERNAL_DELL"
  xrandr --output $EXTERNAL_DELL --primary --scale 1x1 --mode 3440x1440 --$DIRECTION $INTERNAL
elif (xrandr | grep "^$EXTERNAL_OTHER connected"); then
  echo "$EXTERNAL_OTHER connected."
  echo "Setting up primiary to 2560x1440 with no scaling (small font)."
  xrandr --output $INTERNAL --scale 1x1 --mode 2560x1440
  echo "Setting external_other $EXTERNAL_OTHER"
  xrandr --output $EXTERNAL_OTHER --primary --scale 1x1 --mode 2560x1440 --$DIRECTION $INTERNAL
else
  echo "No external monitor connected"
  echo "Setting up primiary to 2560x1440 with 0.9 scaling (slightly largr font)."
  xrandr --output $INTERNAL --primary --scale 0.9x0.9 --mode 2560x1440
  echo "Turning off everything else."
  xrandr --output $EXTERNAL_DELL --off
  xrandr --output $EXTERNAL_OTHER --off 
fi
