#!/bin/env bash

set -o nounset                              # Treat unset variables as an error

if xdotool search --classname "TODOLISTTERMINAL"; then
    if xdotool search --onlyvisible --classname "TODOLIST"; then
        i3-msg '[instance="TODOLISTTERMINAL"] move scratchpad;'
    else
        i3-msg '[instance="TODOLISTTERMINAL"] scratchpad show;'
    fi
else
    i3-msg exec "st -n 'TODOLISTTERMINAL' -e nvim +edit note:todo"
fi
