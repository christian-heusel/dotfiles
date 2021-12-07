#!/bin/env bash
set -o nounset                              # Treat unset variables as an error

password=$(gopass list --flat | rofi -dmenu -i -l 5 -p "gopass->qr" | xargs gopass show --password)
tmpfile=$(mktemp /tmp/gopass-qr.XXXXXX)
qrencode "$password" --dpi=500 -s 20 -m 1 -o $tmpfile && sxiv -bpq -Z $tmpfile

rm -v $tmpfile
