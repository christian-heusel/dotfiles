#!/bin/bash

#icon='/home/chris/.config/i3/icons/avatar.png'
icon='/home/chris/.config/i3/icons/avatar_name.png'
tmpbg='/tmp/i3-lock-scrot.png'

scrot "$tmpbg"
#convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"                      #pixelate the image
#convert "$tmpbg" -brightness-contrast -12x-10 "$tmpbg"                  #lower contrast and brightness of the screenshot
#convert "$tmpbg" -blur "0x6" "$tmpbg"                                   #blur the image
#convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"     #place the logo at the center of the screenshot

#conversions combined
convert "$tmpbg" -brightness-contrast -20x-20 -blur "0x5" "$icon" -gravity center -composite -matte "$tmpbg"


#stop spotify
#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop

i3lock -u -t -i $tmpbg
rm $tmpbg
