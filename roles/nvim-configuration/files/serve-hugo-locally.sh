#!/bin/env bash
#===============================================================================
#
#          FILE: serve-locally.sh
#
#         USAGE: ./serve-locally.sh
#
#   DESCRIPTION: open the hugoserver locally for developement purposes
#
#       OPTIONS: ---
#  REQUIREMENTS: hugo, xdg-utils
#        AUTHOR: Christian Heusel (christian@heusel.eu)
#       CREATED: 08/06/20 21:09
#      REVISION: 1
#===============================================================================

set -o nounset                              # Treat unset variables as an error

bindAddr="localhost"
port="8080"

( hugo serve --disableFastRender --bind $bindAddr --port $port --baseUrl http://$bindAddr:$port/ --verbose --source $1 > /dev/null &) && \
    sleep 0.5 && \
    xdg-open http://$bindAddr:$port/

