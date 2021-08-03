#!/bin/bash
name=$(date +'%Y-%m-%d_%H:%M:%S.png')
save_path="/home/chris/Pictures/"
combined=$save_path$name
echo "$save_path$name"
fswebcam --no-overlay --no-underlay --no-banner --png --save ~/$name && \
mv ~/$name $save_path$name && \
xclip -selection clipboard -t image/png -i "$combined" && \
zenity --info --width="280" --height=20 --title "Screenshot" --timeout=1 --text "Your screenshot has been Saved in \n $save_path !" &>/dev/null && \
exit 0
