local mod = "SUPER"

-- window manipulation
hl.bind(mod .. " + escape", hl.dsp.exec_cmd("@WLOGOUT@ -b 5 -T 400 -B 400"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mod .. " + apostrophe", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mod .. " + SHIFT + apostrophe", hl.dsp.focus({ workspace = "next" }))

-- Resize in workspace
hl.bind(mod .. " + CONTROL + h", hl.dsp.layout("splitratio, -0.1"))
hl.bind(mod .. " + CONTROL + l", hl.dsp.layout("splitratio, +0.1"))

-- Layout
hl.bind(mod .. " + CTRL + Space", hl.dsp.window.float())

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:272", hl.dsp.window.float(), { mouse = true, click = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Hyprland misc
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Laptop keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("@PLAYERCTL@ play-pause"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("@QALCULATE@"))

hl.bind(mod .. " + A", hl.dsp.exec_cmd("hyprctl switchxkblayout"))

-- Plugins
hl.bind(
	mod .. " + SHIFT + B",
	hl.dsp.exec_cmd("pypr toggle btm && hyprctl dispatch 'hl.dsp.window.alter_zorder({ mode = \"top\" })'")
)
hl.bind(
	mod .. " + SHIFT + T",
	hl.dsp.exec_cmd("pypr toggle term && hyprctl dispatch 'hl.dsp.window.alter_zorder({ mode = \"top\" })'")
)
hl.bind(
	mod .. " + SHIFT + E",
	hl.dsp.exec_cmd("pypr toggle yazi && hyprctl dispatch 'hl.dsp.window.alter_zorder({ mode = \"top\" })'")
)

-- Apps keybindings
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("@KITTY@"))
hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd("@ZJ_SESSIONS@"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("zen-beta"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("@TELEGRAM@"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("nm-connection-editor"))
hl.bind(mod .. " + U", hl.dsp.exec_cmd("blueman-manager"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("@NAUTILUS@"))

hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t"))

-- Scripts
hl.bind(mod .. " + R", hl.dsp.exec_cmd("anyrun"))
hl.bind(
	mod .. " + V",
	hl.dsp.exec_cmd(
		"cliphist list | anyrun --hide-plugin-info true --max-entries 10 --show-results-immediately true --plugins libstdin.so | cliphist decode | wl-copy"
	)
)

hl.bind(mod .. " + W", hl.dsp.exec_cmd("@WALLPAPER@"))

hl.bind(mod .. " + CTRL + SHIFT + R", hl.dsp.exec_cmd("@INIT_BAR@"))

hl.bind("Print", hl.dsp.exec_cmd("@SCREENSHOT@ -s 3 full"))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd("@SCREENSHOT@ -p area"))

hl.bind(mod .. " + S", hl.dsp.layout("togglesplit"))

-- Change workspace
for i = 1, 9 do
	hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move window to workspace
for i = 1, 9 do
	hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- vim-style keys are aliases of the arrow directions
local directions = {
	left = "l",
	right = "r",
	up = "u",
	down = "d",
	h = "l",
	l = "r",
	k = "u",
	j = "d",
}

-- Move focus
for key, direction in pairs(directions) do
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
end

-- Swap windows
for key, direction in pairs(directions) do
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.swap({ direction = direction }))
end

-- Move windows
for key, direction in pairs(directions) do
	hl.bind(mod .. " + CONTROL + " .. key, hl.dsp.window.move({ direction = direction }))
end

-- Move monitor focus
for key, direction in pairs(directions) do
	hl.bind(mod .. " + ALT + " .. key, hl.dsp.focus({ monitor = direction }))
end

-- Move workspace to other monitor
for key, direction in pairs(directions) do
	hl.bind(mod .. " + ALT + SHIFT + " .. key, hl.dsp.workspace.move({ monitor = direction }))
end
