#!/bin/bash

## TODO: need to fix the issue with \e in Mac OS bash
for i in `seq 1 4`;
do
  echo -en "\e[40m      "  # Black
  echo -en "\e[100m      " # Dark Gray
  echo -en "\e[49m "
  echo -en "\e[41m      "  # Red
  echo -en "\e[101m      " # Light Red 
  echo -en "\e[49m "
  echo -en "\e[42m      "  # Green
  echo -en "\e[102m      " # Light Green
  echo -en "\e[49m "
  echo -en "\e[43m      "  # Yellow 
  echo -en "\e[103m      " # Light Yellow
  echo -en "\e[49m "
  echo -en "\e[44m      "  # Blue
  echo -en "\e[104m      " # Light Blue
  echo -en "\e[49m "
  echo -en "\e[45m      "  # Magenta
  echo -en "\e[105m      " # Light Magenta 
  echo -en "\e[49m "
  echo -en "\e[46m      "  # Cyan
  echo -en "\e[106m      " # Light Cyan
  echo -en "\e[49m "
  echo -en "\e[47m      "  # Light Gray
  echo -en "\e[107m      "  # White
# Reset color and return
  tput sgr0
  echo ""
done

# Reset colors
tput sgr0
echo ""
