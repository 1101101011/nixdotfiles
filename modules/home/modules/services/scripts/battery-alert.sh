#!/usr/bin/env bash

# Send a notification if the laptop battery is either low or is fully charged.
# Set on a systemd timer (~/.config/systemd/user/battery-alert.timer).
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Initialize sums for energy and capacity
sum_energy_now=0
sum_energy_full=0
warning_level=20
critical_level=10
battery_state=$(acpi -b | awk -F', ' '{print $1}' | awk '{print $3}' | grep -E "Full|Charging") 
case $battery_state in
  *Charging*)
    battery_state="Charging"
    ;;
  *Full*)
    battery_state="Full"
    ;;
  *)
    battery_state="Discharging"
    ;;
esac

# Use files to store whether we've shown a notification or not (to prevent multiple notifications)
full_file=/tmp/batteryfull
empty_file=/tmp/batteryempty
critical_file=/tmp/batterycritical

# Reset notifications if the computer is charging/discharging
if [[ "$battery_state" == "Charging" ]]; then
	rm -f $critical_file $empty_file
elif [[ "$battery_state" == "Discharging" ]]; then
	rm -f $full_file
fi

# Iterate over all batteries (e.g., BAT0, BAT1)
for battery in /sys/class/power_supply/BAT*; do
  if [ -d "$battery" ]; then
    # Try to read energy values
    if [ -r "$battery/energy_now" ]  && [ -r "$battery/energy_full" ]; then
      energy_now=$(cat "$battery/energy_now")
      energy_full=$(cat "$battery/energy_full")
    fi
    # Add to total sums
    sum_energy_now=$((sum_energy_now + energy_now))
    sum_energy_full=$((sum_energy_full + energy_full))
  fi
done

# Calculate total percentage
if [ "$sum_energy_full" -gt 0 ]; then
  total_percent=$(( (sum_energy_now * 100) / sum_energy_full ))
else
  notify-send "Battery: Not detected" "Battery is not detected." -i "battery-missing" -r 9991
fi

# If the battery is critical and is not charging (and has not shown notification yet)
if [ "$total_percent" -le $critical_level ] && [ "$battery_state" == "Discharging" ] && [ ! -f $critical_file ]; then
	notify-send "Battery Critical" "${total_percent}% of battery remaining. Charge your PC now!" -u critical -i "battery-010" -r 9991
	touch $critical_file

# If the battery is low and is not charging (and has not shown notification yet)
elif [ "$total_percent" -le $warning_level ] && [ "$battery_state" == "Discharging" ] && [ ! -f $empty_file ]; then
	notify-send "Low Battery" "${total_percent}% of battery remaining." -h string:fgcolor:\#fe8019 -i "battery-020" -r 9991
	touch $empty_file
  
# If the battery is charging and is full (and has not shown notification yet)
#  && [[ "$battery_state" == "Full" ]]
elif [[ "$total_percent" -eq 99 ]] && [[ ! -f $full_file ]]; then
	notify-send "Battery Charged" "Battery is fully charged." -i "battery-100-charged" -r 9991
	touch $full_file
fi

