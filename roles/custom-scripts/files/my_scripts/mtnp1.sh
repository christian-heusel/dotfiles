#!/bin/bash
set -o nounset # Treat unset variables as an error
last_workspace=$(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1) 
i3-msg move container to workspace $((last_workspace + 1))
i3-msg workspace $((last_workspace + 1))



