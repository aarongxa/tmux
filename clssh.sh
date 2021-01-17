#!/bin/bash
#-------------------------------------------------
# Author: Aaron Griffith
# Twitter: @aarongxa
# Purpose: Cluster SSH Script
# Updated: 16 JAN 2021
# Special Note: Please adjust "User Input" to fix your needs
# 
#---------------------------------------------------------


HOSTS=

# Execute script ONLY if tmux is running
if [ -z "$TMUX" ]; then
  echo Must be run from within an active tmux session 1>&2
  exit 1
fi

# User Input - Ex. Inputting dev will connect to (3) development hosts - dev1 dev2 and dev3
#
if [ "$1" = 'dev-hosts' ]; then
    HOSTS="dev-host-1 dev-host-2 dev-host-3"
elif [ "$1" = '' ]; then
    HOSTS=""
elif [ "$1" = '' ]; then
    HOSTS=""
    tmux rename-window "Production"
else
    #Connect to any user inputed hosts"
    HOSTS=$*
    tmux rename-window "Cluster"
fi

# SSH to hosts and arrange tiles
for i in $HOSTS
do
    tmux splitw "ssh $i"
    tmux select-layout tiled
done

# sync panes on
tmux set-window-option synchronize-panes on