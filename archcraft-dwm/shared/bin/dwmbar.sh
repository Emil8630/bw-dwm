#!/usr/bin/bash

interval=0

## Cpu Info
cpu_info() {
	cpu_load=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c#1d1f1d^ ^b#e1e3da^ CPU"
	printf "^c#e1e3da^ ^b#1d1f1d^ $cpu_load"
}

## Memory
memory() {
	printf "^c#e1e3da^^b#1d1f1d^   $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g) "
}

# Networking

## Wi-fi
wlan() {
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
		up) printf "^c#3b414d^^b#7aa2f7^  ^d^%s" " ^c#7aa2f7^Connected " ;;
		down) printf "^c#3b414d^^b#E06C75^ 睊 ^d^%s" " ^c#E06C75^Disconnected " ;;
	esac
}
## Mullvad connection
: <<'COMMENT'

mullvad() {
  status=$(mullvad status)

  # Check if the status contains "Connected" or "Disconnected"
  if [[ $status == "Connected" ]]; then
      printf "^c#B8BAB4^^b#1b1b1b^ 󰒘 "
      printf "^c#0f100f^^b#0f100f^  "
  elif [[ $status == "Disconnected" ]]; then
      printf "^c#B8BAB4^^b#e06c75^ 󰻌 Mullvad is disconnected. " 
      printf "^c#0f100f^^b#0f100f^  "
  else
      printf "^c#B8BAB4^^b#e06c75^ 󰻌 Mullvad is disconnected. " 
      printf "^c#0f100f^^b#0f100f^  "
  fi
}
COMMENT
mullvad2() {

  status_output=$(mullvad status)

  # Get the first word of the output
  status=$(echo "$status_output" | awk '{print $1}')

  # Check if the status is "Connected"
  if [[ "$status" = *"Connected"* ]]; then
    # Parse out the third word
      server=$(echo "$status_output" | awk '{print $3}')
      printf "^c#0f100f^^b#0f100f^  "
      printf "^c#B8BAB4^^b#1b1b1b^ 󰒘 $server "
      printf "^c#0f100f^^b#0f100f^  "
  elif [[ "$status" = *"Disconnected"* ]]; then
      printf "^c#B8BAB4^^b#e06c75^ 󰻌 Mullvad is disconnected. " 
      printf "^c#0f100f^^b#0f100f^  "
  else
      :
  fi

}

## Time
clock() {
	printf "^c#1d1f1d^^b#eef0e9^  "
	printf "^c#1d1f1d^^b#e1e3da^ $(date '+%a %d %b, %H:%M') "
}

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

  sleep 1 && xsetroot -name "$(updates) $(mullvad2) $(kernel) $(clockdark)"
done
