--- Optimize the selected (or hovered) images, videos, PDFs and directories
--- (recursively) with the `optimize` CLI (pkgs/optimize). A file is replaced
--- only when the optimized version is smaller.
---
--- It runs as a yazi shell task, so the progress shows up in the task manager
--- (<Tab>t, then `i` to inspect). When it finishes, the task publishes a
--- summary back to this yazi instance, which shows it as a notification.

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

return {
	setup = function()
		-- Body: "<info|warn>\n<summary>", written by `optimize --summary-file`.
		ps.sub_remote("optimize-done", function(body)
			local text = tostring(body)
			local level, summary = text:match("^(%a+)\n(.-)\n?$")
			if not level then
				level, summary = "info", text
			end
			notify(level, summary, level == "warn" and 10 or 5)
		end)
	end,

	entry = function()
		-- Directories are passed as is: `optimize` walks them recursively and
		-- optimizes every supported file in place, keeping the tree layout.
		local quoted, n_files, n_dirs = {}, 0, 0
		for _, path in ipairs(get_targets()) do
			local ext = path:match("%.([^./]+)$")
			local cha = fs.cha(Url(path), false)
			if cha and (cha.is_dir or (ext and SUPPORTED[ext:lower()])) then
				quoted[#quoted + 1] = ya.quote(path)
				if cha.is_dir then
					n_dirs = n_dirs + 1
				else
					n_files = n_files + 1
				end
			end
		end

		if #quoted == 0 then
			return notify("warn", "Nothing to optimize: select images, videos, PDFs or directories")
		end

		-- `optimize` comes first so the task manager's title starts with it.
		local summary = '"${TMPDIR:-/tmp}/yazi-optimize-$$"'
		local cmd = table.concat({
			"optimize -O -f -s " .. summary .. " -- " .. table.concat(quoted, " "),
			"rc=$?",
			'ya pub-to "$YAZI_ID" optimize-done --str "$(cat '
				.. summary
				.. ' 2>/dev/null || printf "warn\\noptimize exited with %s" "$rc")"',
			"rm -f " .. summary,
			'exit "$rc"',
		}, "; ")

		ya.emit("shell", { cmd })
		local what = {}
		if n_files > 0 then
			what[#what + 1] = string.format("%d file(s)", n_files)
		end
		if n_dirs > 0 then
			what[#what + 1] = string.format("%d dir(s)", n_dirs)
		end
		notify("info", "Optimizing " .. table.concat(what, " + ") .. ", progress in the task manager (<Tab>t)", 3)
	end,
}
