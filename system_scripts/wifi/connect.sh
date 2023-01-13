#!/usr/bin/env bash

if [ -z "$1" ]; then
	options=$("$SYSTEM_SCRIPTS/wifi/scan.sh")

	if [ -z "$options" ]; then
		"$SYSTEM_SCRIPTS/wifi/connect.sh"
		sleep 0.3
		exit
	fi

	selected=$(echo "$options" | fzf)

	if [ -z "$selected" ]; then
		exit
	fi

	read -r -p "Password (if new): " password

	if [ -z "$password" ]; then
		nmcli con up "$selected"
		exit 0
	else
		nmcli dev wifi connect "$selected" password "$password"
		exit 0
	fi
elif [ -z "$2" ]; then
	nmcli con up "$1"
else
	nmcli dev wifi connect "$1" password "$2"
fi
