#!/usr/bin/env sh

killall -q polybar dunst lxpolkit glava
while pgrep -x polybar >/dev/null; do sleep 1; done
polybar main &
