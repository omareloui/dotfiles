local ruled = require("ruled")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local b = beautiful

b.notification_opacity = 0.8
b.notification_spacing = 10
b.notification_bg = "#eeeeee10"

b.notification_shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 6)
end

ruled.notification.connect_signal("request::rules", function()
	ruled.notification.append_rule({
		rule = {},
		properties = {
			opacity = 0.8,
			bg = "#eeeeee10",
			border_width = 1,
			border_color = "#eeeeee",
			margin = 15,
			icon_size = 100,
			font = "Poppins 11",
			timeout = 5,
			implicit_timeout = 5,

			callback = function(args)
				args.title = "<b>" .. args.title .. "</b>" -- .. args.id
				return args
			end,
		},
	})
	ruled.notification.append_rule({
		rule = { urgency = "critical" },
		properties = {
			bg = "#9c1d3860",
			border_color = "#9c1d38",
			timeout = 0,
			implicit_timeout = 0,
		},
	})
end)

naughty.connect_signal("request::display", function(n)
	naughty.layout.box({ notification = n })
end)
