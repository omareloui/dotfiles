--- Move the selected (or hovered) files into a directory, creating it if
--- needed. The name is relative to the current directory unless absolute.
---
--- Never overwrites anything: a file whose name already exists in the target
--- directory is left where it is.

local get_state = ya.sync(function()
	local targets = {}
	for _, file in pairs(cx.active.selected) do
		targets[#targets + 1] = tostring(file.url)
	end
	if #targets == 0 and cx.active.current.hovered then
		targets[1] = tostring(cx.active.current.hovered.url)
	end
	return tostring(cx.active.current.cwd), targets
end)

local function notify(level, content)
	ya.notify({ title = "Fold", content = content, timeout = 5, level = level })
end

return {
	entry = function()
		local cwd, paths = get_state()
		if #paths == 0 then
			return notify("warn", "Nothing selected or hovered")
		end

		local input, event = ya.input({
			title = "Fold to:",
			pos = { "top-center", w = 40 },
			realtime = false,
		})
		if event ~= 1 then
			return
		end
		input = (input or ""):match("^%s*(.-)%s*$")
		if input == "" then
			return
		end

		local dir = Url(input)
		if not dir.is_absolute then
			dir = Url(cwd):join(input)
		end

		local cha = fs.cha(dir, true)
		if cha and not cha.is_dir then
			return notify("error", input .. " already exists and is not a directory")
		end
		if not cha then
			local ok, err = fs.create("dir_all", dir)
			if not ok then
				return notify("error", "Could not create " .. input .. ": " .. tostring(err))
			end
		end

		local problems = {}
		for _, path in ipairs(paths) do
			local src = Url(path)
			local name = src.name
			if dir:starts_with(src) then
				problems[#problems + 1] = name .. ": can't move a directory into itself"
			else
				local dest = dir:join(name)
				if fs.cha(dest, false) then
					problems[#problems + 1] = name .. ": already exists in " .. input .. ", left in place"
				else
					local ok, err = fs.rename(src, dest)
					if not ok then
						problems[#problems + 1] = name .. ": " .. tostring(err)
					end
				end
			end
		end

		if #problems > 0 then
			notify("warn", table.concat(problems, "\n"))
		end
	end,
}
