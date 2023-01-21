local awful = require("awful")
local gears = require("gears")

-- brightness control
return function(globalkeys)
	return gears.table.join(
		globalkeys,

		-- audio control
		awful.key({}, "XF86AudioRaiseVolume", function()
			awful.spawn.with_shell("volume up")
		end),
		awful.key({}, "XF86AudioLowerVolume", function()
			awful.spawn.with_shell("volume down")
		end),
		awful.key({}, "XF86AudioMute", function()
			awful.spawn.with_shell("volume mute")
		end),

		-- brightness control
		awful.key({}, "XF86MonBrightnessDown", function()
			awful.spawn.with_shell("brightnessctl set 20-")
		end),

		awful.key({}, "XF86MonBrightnessUp", function()
			awful.spawn.with_shell("brightnessctl set +20")
		end)
	)
end
