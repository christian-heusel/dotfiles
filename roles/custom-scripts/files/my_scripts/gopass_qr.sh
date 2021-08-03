#!/bin/env bash
set -o nounset                              # Treat unset variables as an error

password=$(gopass list --flat | rofi -dmenu -i -l 5 -p "gopass->qr" -config "/home/chris/.config/rofi/rofi.conf" | xargs gopass show --password)
tmpfile=$(mktemp /tmp/gopass-qr.XXXXXX)
qrencode $password -o $tmpfile && sxiv -bpq -z 130 $tmpfile

rm -v $tmpfile
