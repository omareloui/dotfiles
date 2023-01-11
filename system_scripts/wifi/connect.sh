#!/usr/bin/env bash

if [ -z "$2" ]; then
	nmcli crone up "$1"
else
	nmcli dev wifi connect "$1" password "$2"
fi
