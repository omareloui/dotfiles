local awful = require("awful")

awful.spawn.with_shell('xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Tapping Enabled" 1')
awful.spawn.with_shell(
	'xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Natural Scrolling Enabled" 1'
)
