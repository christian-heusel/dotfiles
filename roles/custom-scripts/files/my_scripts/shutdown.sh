#!/bin/bash

zenity --question --width="370" --height=20 --title "System Shutdown" --timeout=5 --text "You pressed the system shutdown shortcut. \nDo you want to proceed?" \
&& sudo shutdown 0

