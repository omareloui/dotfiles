#!/usr/bin/env bash

is_charging=$1
current_percentage=$(acpi | grep -Po '[0-9]{1,2}(?=%)')

# TODO: in setup script move the icons to ~/.local/share/icons/
# and sounds to ~/.local/share/sounds/
# and use the icons in the original script with it

# FIXME: Doesn't override!!
NOTIFICATION_ID=80008

if [ "$is_charging" -eq 1 ]; then
	notify-send "Charging" "$current_percentage% of battery charged." -u low -i "$SYSTEM_SCRIPTS/battery/icons/battery-charging.png" -t 5000 -r "$NOTIFICATION_ID"
	paplay "/usr/share/sounds/Yaru/stereo/power-plug.oga"
elif [ "$is_charging" -eq 0 ]; then
	notify-send "Disconnected" "$current_percentage% of battery remaining." -u low -i "$SYSTEM_SCRIPTS/battery/icons/battery-minus.png" -t 5000 -r "$NOTIFICATION_ID"
	paplay "/usr/share/sounds/Yaru/stereo/power-unplug.oga"
fi
