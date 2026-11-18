--- Flatten the selected (or hovered) directories: move their children into
--- the directory that contains them, then remove them if they end up empty.
---
--- Never overwrites anything: a child whose name already exists next to the
--- directory is left inside it, and the directory is kept.

local get_targets = ya.sync(function()
	local targets = {}
	for _, file in pairs(cx.active.selected) do
		targets[#targets + 1] = tostring(file.url)
	end
	if #targets == 0 and cx.active.current.hovered then
		targets[1] = tostring(cx.active.current.hovered.url)
	end
	return targets
end)

local function notify(level, content)
	ya.notify({ title = "Unfold", content = content, timeout = 5, level = level })
end

---@param dir Url
---@return string[] problems
local function unfold(dir)
	local name = dir.name
	local parent = dir.parent
	if not name or not parent then
		return { tostring(dir) .. ": no parent directory" }
	end

	-- Move the directory out of the way first, so a child with the same name as
	-- the directory (e.g. `proj/proj`) can take its place.
	local tmp, err = fs.unique("dir", parent:join(".unfold-" .. name))
	if not tmp then
		return { name .. ": " .. tostring(err) }
	end
	fs.remove("dir", tmp)
	local ok
	ok, err = fs.rename(dir, tmp)
	if not ok then
		return { name .. ": " .. tostring(err) }
	end

	local problems = {}
	local children
	children, err = fs.read_dir(tmp, { resolve = false })
	if not children then
		problems[#problems + 1] = name .. ": " .. tostring(err)
		children = {}
	end

	for _, child in ipairs(children) do
		local child_name = child.url.name
		local target = parent:join(child_name)
		if fs.cha(target, false) then
			problems[#problems + 1] = name .. "/" .. child_name .. ": already exists, left in place"
		else
			ok, err = fs.rename(child.url, target)
			if not ok then
				problems[#problems + 1] = name .. "/" .. child_name .. ": " .. tostring(err)
			end
		end
	end

	-- Only succeeds if it is empty now.
	if fs.remove("dir", tmp) then
		return problems
	end

	-- Something stayed behind: put the directory back, under its old name if
	-- that is still free.
	local back = dir
	if fs.cha(back, false) then
		back = fs.unique("dir", dir)
		if back then
			fs.remove("dir", back)
		end
	end
	if back and fs.rename(tmp, back) then
		if tostring(back) ~= tostring(dir) then
			problems[#problems + 1] = "kept the leftovers of " .. name .. " in " .. back.name
		end
	else
		problems[#problems + 1] = "kept the leftovers of " .. name .. " in " .. tmp.name
	end
	return problems
end

return {
	entry = function()
		local problems = {}
		local count = 0
		for _, path in ipairs(get_targets()) do
			local url = Url(path)
			local cha = fs.cha(url, false)
			if cha and cha.is_dir then
				count = count + 1
				for _, p in ipairs(unfold(url)) do
					problems[#problems + 1] = p
				end
			end
		end

		if count == 0 then
			notify("warn", "Nothing to flatten: no directory selected or hovered")
		elseif #problems > 0 then
			notify("warn", table.concat(problems, "\n"))
		end
	end,
}
