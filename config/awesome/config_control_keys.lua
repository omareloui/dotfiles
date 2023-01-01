local awful = require("awful")
local gears = require("gears")

-- brightness controll
return function(globalkeys)
	return gears.table.join(
		globalkeys,

		-- audio control
		awful.key({}, "XF86AudioRaiseVolume", function()
			awful.spawn.with_shell("amixer -c 1 set Master 9%+ unmute")
		end),
		awful.key({}, "XF86AudioLowerVolume", function()
			awful.spawn.with_shell("amixer -c 1 set Master 9%- unmute")
		end),
		awful.key({}, "XF86AudioMute", function()
			awful.spawn.with_shell("amixer -c 1 set Master togglemute")
		end),

		-- brightness controll
		awful.key({}, "XF86MonBrightnessDown", function()
			awful.spawn.with_shell("brightnessctl set 10-")
		end),

		awful.key({}, "XF86MonBrightnessUp", function()
			awful.spawn.with_shell("brightnessctl set +10")
		end)
	)
end
