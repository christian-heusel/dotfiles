#!/bin/bash -
#===============================================================================
#
#          FILE: update_and_run.sh
#
#         USAGE: ./update_and_run.sh
#
#   DESCRIPTION: Pulls and runs my dotfile configuration
#
#  REQUIREMENTS: git, ansible-playbook, moreutils, zenity
#        AUTHOR: Christian Heusel (christian@heusel.eu)
#       CREATED: 08/12/2021 11:40
#
#===============================================================================

set -o history -o histexpand                # set these so !! is defined
set -o nounset                              # Treat unset variables as an error

error_text=""

# this gets the return code and full command
check_error () {
    if [ $1 -eq 0 ]; then
        echo OK
    else
        error_text="There was an error executing \"${@:2}\""
        echo "$error_text"
        GTK_THEME="Arc:dark" zenity --error --width="500" --height=20 --timeout=5 \
               --text "$error_text" --title "$0"
        exit 1
    fi
}

state_file=$XDG_STATE_HOME/dotfiles_last_run_commit

cd {{ playbook_dir }}
git pull --autostash
check_error $? !!

current_commit_sha=$(git rev-parse HEAD)
previous_commit_sha=$(cat $state_file | head -1)


if [[ "$current_commit_sha" != "$previous_commit_sha" ]]; then
    chronic -v ansible-playbook 01_configure.yml
    check_error $? !!

    # we did a successfull run and can therefore save the new commit sha
    echo "$current_commit_sha" > $state_file
    echo "Last dotfile update was run on $(date)" >> $state_file
else
    echo "Not running since there are no new updates (SHA: $current_commit_sha)"
fi
