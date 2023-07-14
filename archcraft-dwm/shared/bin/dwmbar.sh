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

## Wi-fi
wlan() {
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
		up) printf "^c#3b414d^^b#7aa2f7^  ^d^%s" " ^c#7aa2f7^Connected " ;;
		down) printf "^c#3b414d^^b#E06C75^ 睊 ^d^%s" " ^c#E06C75^Disconnected " ;;
	esac
}

## Time
clock() {
	printf "^c#1d1f1d^^b#eef0e9^  "
	printf "^c#1d1f1d^^b#e1e3da^ $(date '+%a %d %b, %H:%M') "
}

## System Update
updates() {
	updates=$(checkupdates | wc -l)

	if [ "$updates" -ge 500 ]; then
		printf "^c#e1e3da^  $updates"" updates"
    #printf "^c#e1e3da^  Updated"
  elif [[ "$updates" -ge 1000 ]]; then
    printf "^c#FF0000^  $updates"" updates" 
	else
		time
	fi
}


## Main
while true; do
  [ "$interval" == 0 ] || [ $(("$interval" % 3600)) == 0 ] && updates=$(updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(updates) $(clock)"
done
