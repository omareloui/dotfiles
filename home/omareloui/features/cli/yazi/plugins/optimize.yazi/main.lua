--- Optimize the selected (or hovered) images, videos and PDFs in the background
--- with the `optimize` CLI (pkgs/optimize). A file is replaced only when the
--- optimized version is smaller.

local SUPPORTED = {
	jpg = true,
	jpeg = true,
	png = true,
	webp = true,
	gif = true,
	mp4 = true,
	m4v = true,
	mov = true,
	mkv = true,
	avi = true,
	webm = true,
	pdf = true,
}

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

local function notify(level, content, timeout)
	ya.notify({ title = "Optimize", content = content, timeout = timeout or 5, level = level })
end

---@param path string
---@return integer|nil
local function size_of(path)
	local cha = fs.cha(Url(path), false)
	return cha and not cha.is_dir and cha.len or nil
end

return {
	entry = function()
		local paths, before = {}, {}
		for _, path in ipairs(get_targets()) do
			local ext = path:match("%.([^./]+)$")
			local size = size_of(path)
			if size and ext and SUPPORTED[ext:lower()] then
				paths[#paths + 1] = path
				before[path] = size
			end
		end

		if #paths == 0 then
			return notify("warn", "Nothing to optimize: select images, videos or PDFs")
		end

		local label = #paths == 1 and Url(paths[1]).name or (#paths .. " files")
		notify("info", "Optimizing " .. label .. "…", 3)

		local output, err = Command("optimize")
			:arg({ "-q", "-O", "-f" })
			:arg(paths)
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:output()
		if not output then
			return notify("error", "Could not run optimize: " .. tostring(err))
		end

		local optimized, unchanged, failed = 0, 0, {}
		local total_before, total_after = 0, 0
		local failed_paths = {}
		for line in (output.stderr or ""):gmatch("[^\n]+") do
			if line:find("Optimization failed", 1, true) then
				for _, path in ipairs(paths) do
					if line:find(path, 1, true) then
						failed_paths[path] = true
					end
				end
			end
		end

		for _, path in ipairs(paths) do
			local name = Url(path).name
			local after = size_of(path)
			if not after or failed_paths[path] then
				failed[#failed + 1] = name
			elseif after < before[path] then
				optimized = optimized + 1
				total_before = total_before + before[path]
				total_after = total_after + after
			else
				unchanged = unchanged + 1
			end
		end

		local lines = {}
		if optimized > 0 then
			local saved = total_before - total_after
			lines[#lines + 1] = string.format(
				"%d optimized, saved %s (%d%%)",
				optimized,
				ya.readable_size(saved),
				math.floor(saved * 100 / total_before)
			)
		end
		if unchanged > 0 then
			lines[#lines + 1] = unchanged .. " already optimal, kept as is"
		end
		if #failed > 0 then
			lines[#lines + 1] = "Failed: " .. table.concat(failed, ", ")
		end

		notify(#failed > 0 and "warn" or "info", table.concat(lines, "\n"), #failed > 0 and 10 or 5)
	end,
}
