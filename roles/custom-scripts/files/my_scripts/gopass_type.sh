#!/bin/env bash
set -o nounset                              # Treat unset variables as an error

pw_path=$(gopass --nosync list --flat | rofi -dmenu -i -l 5 -p "gopass->xdo")
password=$(gopass --nosync show --password "${pw_path}")

if [[ -n "${password}" ]]; then
    xdotool sleep 3
    xdotool type "${password}"
    # xdotool key KP_Enter
fi
