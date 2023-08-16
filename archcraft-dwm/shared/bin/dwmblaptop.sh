#!/usr/bin/bash

interval=0


# Networking

## Time

clockdark() {
    #printf "^c#B8BAB4^^b#0f100f^  "
    printf "^c#B8BAB4^^b#1b1b1b^  $(date '+%a %d %b, %H:%M') "
}

## System Update
updates() {
    updates=$(checkupdates | wc -l)

    if [ "$updates" -ge 300 ]; then
    printf "^c#B8BAB4^^b#1b1b1b^  $updates updates "
    printf "^c#0f100f^^b#0f100f^  "
    #printf "^c#e1e3da^  Updated"
  elif [[ "$updates" -ge 1000 ]]; then
#    printf "^c#e06c75^  $updates"" updates" 
    printf "^c#B8BAB4^^b#e06c75^  $updates updates "
    printf "^c#0f100f^^b#0f100f^  "
    else
    :
    fi
}



## Kernel Version
kernel() {
	#printf "^c#B8BAB4^^b#0f100f^  "
	printf "^c#B8BAB4^^b#1b1b1b^  $(uname -r) "
	printf "^c#0f100f^^b#0f100f^  "
}

## Main
while true; do
  [ "$interval" == 0 ] || [ $(("$interval" % 3600)) == 0 ] && updates=$(updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(updates) $(kernel) $(clockdark)"
done
