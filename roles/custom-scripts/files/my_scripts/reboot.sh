#!/bin/bash

zenity --question --width="370" --height=20 --title "System Reboot" --timeout=5 --text "You pressed the system reboot shortcut. \nDo you want to proceed?" \
&& sudo reboot

