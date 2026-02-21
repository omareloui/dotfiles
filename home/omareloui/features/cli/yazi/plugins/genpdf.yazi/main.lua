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

---@param paths string[]
---@return string|nil error_message
local function genpdf(paths)
	local child, err = Command("genpdf"):arg(paths):spawn()
	if err then
		return "error while creating the genpdf child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the genpdf child: " .. err
	end
end

return {
	entry = function()
		---@type string[]
		local paths = get_selected()
		ya.debug("Generating PDF for paths: " .. table.concat(paths, ", "))

		local err = genpdf(paths)
		if err then
			ya.err(err)
			return
		end
	end,
}
