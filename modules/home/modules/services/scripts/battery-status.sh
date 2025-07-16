#!/usr/bin/env bash

# Send a notification if the laptop battery is either low or is fully charged.
# Set on a systemd timer (~/.config/systemd/user/battery-alert.timer).
export DISPLAY=":0"
# export XAUTHORITY="/home/Shiroe/.Xauthority"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Initialize sums for energy, capacity, and battery state
sum_energy_now=0
sum_energy_full=0
battery_state=$1

# Check battery status
case "$battery_state" in
  "Charging") 
    battery_status="Charging" 
    battery_icon="battery-100-charged" ;;
  "Discharging")
    battery_status="Discharging" 
    battery_icon="battery-100" ;;
esac

# Iterate over all batteries (e.g., BAT0, BAT1)
for battery in /sys/class/power_supply/BAT*; do
  if [ -d "$battery" ]; then
    # Try to read energy values
    if [ -r "$battery/energy_now" ] && [ -r "$battery/energy_full" ]; then
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
  /run/current-system/sw/bin/notify-send "Battery: Not detected" "Battery is not detected." -i "battery-missing" -r 9991
fi

# Send battery status notification
/run/current-system/sw/bin/notify-send "${battery_status}" "${total_percent}% of battery charged." -u normal -i "battery-${battery_icon}" -t 5000 -r 9991

