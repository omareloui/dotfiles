#!/bin/bash

xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Tapping Enabled" 1
xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Natural Scrolling Enabled" 1