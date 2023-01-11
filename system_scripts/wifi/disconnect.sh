#!/usr/bin/env bash

current_connection=$(iwconfig wlp3s0 | grep "ESSID" | sed 's/.*"\(.*\)".*/\1/')

nmcli con down "$current_connection"
