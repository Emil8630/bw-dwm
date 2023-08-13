#!/usr/bin/bash

interval=0


## Battery

battery() {

    battery_state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'state:\s+\K\w+')
    
    if [[ $battery_state == "discharging" ]]; then
        battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'percentage:\s+\K\d+%')

        if [[ -n $battery_percentage ]]; then
            percentage_number=${battery_percentage%\%}  # Remove the '%' sign
            if ((percentage_number >= 100)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁹 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 90)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂂 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 80)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂁 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 70)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂀 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 60)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁿 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 50)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁾 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 40)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁽 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 30)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁼 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 20)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰁻 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 10)); then
                printf "^c#B8BAB4^^b#c18873^ 󰁺 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 5)); then
                printf "^c#B8BAB4^^b#e06c75^ 󰂃 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            else
                :
            fi
        else
            :
        fi
    elif [[ $battery_state == "charging" ]]; then
        battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'percentage:\s+\K\d+%')

        if [[ -n $battery_percentage ]]; then
            percentage_number=${battery_percentage%\%}  # Remove the '%' sign
            if ((percentage_number >= 100)); then
                printf "^c#B8BAB4^^b#58d3a9^ 󰂅 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 90)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂋 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 80)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂊 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 70)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰢞 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 60)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂉 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 50)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰢝 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 40)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂈 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 30)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂇 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 20)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰂆 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
            elif ((percentage_number >= 10)); then
                printf "^c#B8BAB4^^b#1b1b1b^ 󰢜 $battery_percentage% "
                printf "^c#0f100f^^b#0f100f^  "
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

  sleep 1 && xsetroot -name "$(updates) $(mullvad) $(kernel) $(clockdark)"
done
