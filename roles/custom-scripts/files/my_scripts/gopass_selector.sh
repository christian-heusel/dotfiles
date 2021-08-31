#!/bin/env bash
set -o nounset                              # Treat unset variables as an error

gopass list --flat | \
  rofi -dmenu -i -l 5 -p "gopass" | \
  tee >(xargs gopass show -c) \
      >(awk '{b=$1" ins clipboard kopiert!"; print b}' | xargs -I "{}" notify-send "gopass" "{}")

