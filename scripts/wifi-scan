#!/usr/bin/env bash

sudo iwlist wlp3s0 scan |
	grep "SSID" |
	sed "s/\"//g" |
	sed "s/ESSID://g" |
	sed "s/\s*//g"
