#!/bin/bash
set -o nounset # Treat unset variables as an error
workspace=$(GTK_THEME="Arc:dark" zenity --entry --width=300 --text "Please enter a workspace" 2>/dev/null)
[ -z $workspace ] && i3-msg "move container to workspace $workspace; workspace $workspace"
