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

## Battery
: '
battery() {

    battery_state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'state:\s+\K\w+')
    
    if [[ $battery_state == "discharging" ]]; then
        battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'percentage:\s+\K\d+%')

        if [[ -n $battery_percentage ]]; then
            percentage_number=${battery_percentage}  # Remove the '%' sign
            if ((percentage_number >= 100)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁹 $battery_percentage "
            elif ((percentage_number >= 90)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂂 $battery_percentage "
            elif ((percentage_number >= 80)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂁 $battery_percentage "
            elif ((percentage_number >= 70)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂀 $battery_percentage "
            elif ((percentage_number >= 60)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁿 $battery_percentage "
            elif ((percentage_number >= 50)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁾 $battery_percentage "
            elif ((percentage_number >= 40)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁽 $battery_percentage "
            elif ((percentage_number >= 30)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁼 $battery_percentage "
            elif ((percentage_number >= 20)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁻 $battery_percentage "
            elif ((percentage_number >= 10)); then
                printf "^c#B8BAB4^^b#c18873^ 󰁺 $battery_percentage "
            elif ((percentage_number >= 5)); then
                printf "^c#B8BAB4^^b#e06c75^ 󰂃 $battery_percentage "
            else
                :
            fi
        else
            :
        fi
    elif [[ $battery_state == "charging" ]]; then
        battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'percentage:\s+\K\d+%')

        if [[ -n $battery_percentage ]]; then
            percentage_number=${battery_percentage}  # Remove the '%' sign
            if ((percentage_number >= 100)); then
                printf "^c#B8BAB4^^b#58d3a9^ 󰂅 $battery_percentage "
            elif ((percentage_number >= 90)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂋 $battery_percentage "
            elif ((percentage_number >= 80)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂊 $battery_percentage "
            elif ((percentage_number >= 70)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰢞 $battery_percentage "
            elif ((percentage_number >= 60)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂉 $battery_percentage "
            elif ((percentage_number >= 50)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰢝 $battery_percentage "
            elif ((percentage_number >= 40)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂈 $battery_percentage "
            elif ((percentage_number >= 30)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂇 $battery_percentage "
            elif ((percentage_number >= 20)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂆 $battery_percentage "
            elif ((percentage_number >= 10)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰢜 $battery_percentage "
            else
                :
            fi
        else
            :
        fi
    else
        :
    fi

}
'
# Networking

## Wi-fi
#wlan() {

#  target_host="8.8.8.8"  # Google's DNS server
:'
# Run ping and capture output
  ping_output=$(ping -c 4 -q $target_host)

# Extract round-trip times from ping output
  rtt_min=$(echo "$ping_output" | awk -F '/' 'END {print $4}')
  rtt_avg=$(echo "$ping_output" | awk -F '/' 'END {print $5}')
  rtt_max=$(echo "$ping_output" | awk -F '/' 'END {print $6}')

# Calculate rough download and upload speeds
  download_speed=$(echo "scale=2; 1000 / $rtt_avg" | bc)
  upload_speed=$(echo "scale=2; 1000 / $rtt_max" | bc)

	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
    up) printf "^c#B8BAB4^^b#1b1b1b^  ^d^%s Connected ( $upload_speed/ $download_speed)" ;;
    down) printf "^c#B8BAB4^^b#1b1b1b^ 睊 ^d^%s Disconnected" ;;
	esac
}
'
## Mullvad connection
mullvad() {

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
      printf "^c#B8BAB4^^b#e06c75^ 󰦞 Mullvad is disconnected. " 
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

  sleep 1 && xsetroot -name "$(updates) $(mullvad) $(kernel) $(clockdark)"
done
