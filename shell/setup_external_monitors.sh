#!/bin/bash


# Only works with GNU version of grep
# TODO: this can be further improved by checking on "disconnected" as well.
INTERNAL=`xrandr | grep -oP "(?=^)eDP-*1(?= connected)"`
EXTERNAL_DP=`xrandr | grep -oP "(?=^)DP-*1(?= connected)"`
EXTERNAL_HDMI=`xrandr | grep -oP "(?=^)HDMI-*1(?= connected)"`

echo $INTERNAL
echo $EXTERNAL_DP
echo $EXTERNAL_HDMI

if [ -n "$EXTERNAL_DP" ]; then
  echo "$EXTERNAL_DP connected as external monitor. Setting it as primary."
  xrandr --output $EXTERNAL_DP --primary --scale 1x1 --mode 3440x1440 --$DIRECTION $INTERNAL
  echo "Setting up laptop monitor as secondary with no scaling."
  xrandr --output $INTERNAL --scale 1x1 --mode 2560x1440
elif [ -n "$EXTERNAL_HDMI" ]; then
  echo "$EXTERNAL_HDMI connected as external monitor. Setting it as primary."
  xrandr --output $EXTERNAL_HDMI --primary --scale 1x1 --mode 3440x1440 --$DIRECTION $INTERNAL
  echo "Setting up laptop monitor as secondary with no scaling."
  xrandr --output $INTERNAL --scale 1x1 --mode 2560x1440
else
  echo "No external monitor connected"
  echo "Setting up laptop monitor as primiary to 2560x1440 with 0.9 scaling (slightly largr font)."
  xrandr --output $INTERNAL --primary --scale 0.9x0.9 --mode 2560x1440
  echo "Turning off everything else if previously connected."
  xrandr --output DP-1 --off
  xrandr --output HDMI-1 --off
  xrandr --output DP1 --off
  xrandr --output HDMI1 --off
fi
