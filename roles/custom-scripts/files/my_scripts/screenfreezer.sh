#!/bin/bash

tmpbg='/tmp/screen.png'

scrot "$tmpbg"

i3lock -u -i $tmpbg
rm $tmpbg
