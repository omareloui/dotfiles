#!/usr/bin/env bash

# for the cron
export XDG_RUNTIME_DIR="/run/user/1000"

LOW_NOTF_FILE="/tmp/battery_low"
CHARGED_FILE="/tmp/battery_full"

WARNING_LEVELS=(20 5 3)
CHARGED_ON=100

current_percentage=$(acpi | grep -Po '[0-9]{1,2}(?=%)')
is_discharging=$(acpi | grep -c "Discharging")

notified_for=$(cat "$LOW_NOTF_FILE")

# same id as on_plug
NOTIFICATION_ID=80008

# Notification on charged
if
	[[ "$current_percentage" -gt "$CHARGED_ON" &&
		"$is_discharging" -eq 0 &&
		! -f "$CHARGED_FILE" ]]
then
	notify-send "Battery Charged" "Battery is fully charged." -r "$NOTIFICATION_ID"
	paplay "/usr/share/sounds/Yaru/stereo/complete.oga"
	touch "$CHARGED_FILE"
elif [[ "$is_discharging" -eq 1 && -f "$CHARGED_FILE" ]]; then
	rm "$CHARGED_FILE"
fi

# Warning on discharge
for warning_level in "${WARNING_LEVELS[@]}"; do
	should_notify=1
	for item in $notified_for; do
		[[ "$warning_level" == "$item" ]] && should_notify=0
	done

	if [[ "$is_discharging" -eq 1 &&
		"$current_percentage" -le $warning_level &&
		$should_notify -eq 1 ]]; then
		notify-send "Low battery" "$current_percentage% of battery remaining" -u critical -r "$NOTIFICATION_ID"
		paplay "/usr/share/sounds/Yaru/stereo/battery-low.oga"
		notified_for+=("$warning_level")
	fi
done

if [[ "$is_discharging" -eq 0 && "${#notified_for[@]}" -gt 0 ]]; then
	notified_for=()
fi

echo "${notified_for[*]}" >"$LOW_NOTF_FILE"
