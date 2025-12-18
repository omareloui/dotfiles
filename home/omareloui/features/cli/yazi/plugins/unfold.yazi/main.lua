---@param s string
---@return string
local function trim(s)
	return s:match("^%s*(.-)%s*$")
end

---@param s string
---@return string[]
local function get_lines(s)
	local lines = {}
	for str in s:gmatch("[^\r\n]+") do
		table.insert(lines, str)
	end
	return lines
end

---@param path string
---@return  string|nil mime,string|nil err
local function get_mime(path)
	local out, err = Command("file"):arg({ "-b", path }):output()
	if err then
		return nil, "error while getting the mime type: " .. err
	end
	return trim(out.stdout)
end

---@param path string
---@return  boolean mime, string|nil err
local function is_dir(path)
	local mime, err = get_mime(path)
	if err then
		return false, err
	end
	return mime == "directory"
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

local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

---@param dirname string
---@param files string[]
---@return string|nil error_message
local function mv_to_dir(dirname, files)
	local child, err = Command("mkdir"):arg({ "-p", dirname }):spawn()
	if err then
		return "error while creating the mkdir child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the mkdir child: " .. err
	end

	local child, err = Command("mv"):arg(files):arg(dirname):spawn()
	if err then
		return "error while creating the mv child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the mv child: " .. err
	end
end

---@param dirname string
---@return string|nil error_message
local function rmdir(dirname)
	local child, err = Command("rmdir"):arg(dirname):spawn()
	if err then
		return "error while creating the mkdir child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the mkdir child: " .. err
	end
end

---@param dir string
---@return string[] children, string|nil error
local function get_children(dir)
	local out, err = Command("fd"):arg({ "-IHd1", ".", dir }):output()
	if err then
		return {}, "error while getting the children: " .. err
	end
	return get_lines(trim(out.stdout))
end

return {
	entry = function()
		---@type string[]
		local paths = get_selected()
		local dirs = {}
		for _, v in ipairs(paths) do
			if is_dir(v) then
				table.insert(dirs, v)
			end
		end

		for _, dir in ipairs(dirs) do
			local children, err = get_children(dir)
			if err then
				ya.err(err)
				return
			end

			err = mv_to_dir(get_cwd(), children)
			if err then
				ya.err(err)
				return
			end

			err = rmdir(dir)
			if err then
				ya.err(err)
				return
			end
		end
	end,
}
