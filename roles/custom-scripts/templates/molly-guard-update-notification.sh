#!/bin/bash - 
#===============================================================================
#
#          FILE: molly-guard-update-notification.sh
#
#         USAGE: ./molly-guard-update-notification.sh
#
#   DESCRIPTION: checks to see if there is a new version for molly-guard
#
#        AUTHOR: Christian Heusel (christian@heusel.eu)
#       CREATED: 08/15/2022 13:23
#
#===============================================================================

set -o nounset                              # Treat unset variables as an error

aur_version=$(curl --silent https://aur.archlinux.org/rpc/\?v\=5\&type\=search\&arg\=molly-guard | jq ".results[0].Version" | sed "s&\"&&g")
upstream_version=$(curl --silent https://sources.debian.org/api/src/molly-guard/ | jq ".versions[].version" | sort --reverse --version-sort | head -1 | sed "s&\"&&g")

if [ $(vercmp $aur_version $upstream_version) -ne 0 ]; then
    echo $aur_version $upstream_version $(vercmp $aur_version $upstream_version)
    zenity --question --width="370" --height=20  \
        --title "Version Update Notification" \
        --text "Version Change for molly-guard\nVersion in AUR is: $aur_version \n Version in Debian is: $upstream_version"
fi
