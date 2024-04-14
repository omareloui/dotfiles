---@param s string
---@return string
local function trim(s)
	return s:match("^%s*(.-)%s*$")
end

local get_selected = ya.sync(function(state)
	local sel = cx.active.selected
	if #sel == 0 then
		sel = { cx.active.current.hovered.url }
	end
	state.selected = {}
	for _, file in pairs(sel) do
		table.insert(state.selected, tostring(file))
	end
	return state.selected, nil
end)

---@param dirname string
---@param files string[]
---@return string|nil error_message
local function mv_to_dir(dirname, files)
	local child, err = Command("mkdir"):args({ "-p", dirname }):spawn()
	if err then
		return "error while creating the mkdir child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the mkdir child: " .. err
	end

	local child, err = Command("mv"):args(files):arg(dirname):spawn()
	if err then
		return "error while creating the mv child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the mv child: " .. err
	end
end

return {
	entry = function()
		local dirname, event = ya.input({
			title = "Fold to:",
			position = { "top-center", w = 40 },
			realtime = false,
		})

		local confirmed = event == 1
		dirname = trim(dirname)
		if not confirmed or dirname == "" then
			return
		end

		local files = get_selected()

		local error = mv_to_dir(dirname, files)
		if error then
			ya.err(error)
		end
	end,
}
