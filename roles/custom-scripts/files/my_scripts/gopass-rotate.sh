#!/bin/bash -
#===============================================================================
#
#          FILE: gopass-rotate.sh
#
#         USAGE: ./gopass-rotate.sh 
#
#   DESCRIPTION: fuzzy searches for secrets and renews selected ones
#
#        AUTHOR: Christian Heusel (christian@heusel.eu)
#       CREATED: 11/01/2022 22:29
#
#===============================================================================

set -o nounset                              # Treat unset variables as an error

gum_print () {
    echo $1 | gum format --type emoji | gum format --type template
}

ensure_nonempty () {
    if [[ -z "$1" ]]; then
        gum_print "{{ Bold \"""$2""\" }}"
        exit 1
    fi
}

rotate_secret () {
    gum_print ":fire: now working on \"$1\""
    gum_print ":arrows_counterclockwise: old version of \"$1\" copied to clipboard"
    gopass show --clip $1
    gum input --placeholder="Press [Enter] to continue .."
    gum_print ":new: setting new password for \"$1\""
    gopass generate --force $1
}

gum_print '{{ Bold ":lock: Which password(s) do you want to rotate?" }}'
secret_name=$(gum input --placeholder "Please enter the secrets name")
ensure_nonempty "$secret_name" ':x: No input given, exiting!'

password_names_list=$(gopass list --flat)
search_results=$(echo "$password_names_list" | fzf --filter="$secret_name")
ensure_nonempty "$search_results" ":x: No secrets found!"

gum_print '{{ Bold ":key: Select the secrets you want to rotate from the list:" }}'
# echo "$search_results" | gum choose --selected-prefix="[x] " --unselected-prefix="[ ] " --cursor-prefix="[ ] " --no-limit
rotate_secrets=$(echo "$search_results" | gum choose --no-limit \
    --selected-prefix="$(gum format -t emoji ":white_check_mark:" | xargs) " \
    --unselected-prefix="$(gum format -t emoji ":x:" | xargs) " \
    --cursor-prefix="$(gum format -t emoji ":thinking:" | xargs) ")

for secret in $rotate_secrets; do
    rotate_secret $secret
done

gum_print '{{ Bold ":tada: We are done!" }}'
