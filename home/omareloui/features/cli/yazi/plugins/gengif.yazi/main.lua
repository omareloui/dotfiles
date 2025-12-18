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
local function gengif(paths)
	local child, err = Command("gengif"):arg(paths):spawn()
	if err then
		return "error while creating the gnegif child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the gnegif child: " .. err
	end
end

return {
	entry = function()
		---@type string[]
		local paths = get_selected()

		local err = gengif(paths)
		if err then
			ya.err(err)
			return
		end
	end,
}
