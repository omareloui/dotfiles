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

local get_cwd = ya.sync(function(state)
	local cwd = cx.active.current.cwd
	state.cwd = tostring(cwd)
	return state.cwd
end)

---@param cwd string
---@param abs_paths string[]
---@return string[]|nil rel_paths, string|nil error_message
local function get_rel_paths(cwd, abs_paths)
	local rel_paths = {}
	for _, abs_path in ipairs(abs_paths) do
		local out, err = Command("realpath"):args({ "-s", "--relative-to", cwd, abs_path }):output()
		local rel_path = out.stdout
		rel_path = trim(rel_path)
		if err then
			return nil, "error while getting the relative path: " .. err
		end
		table.insert(rel_paths, rel_path)
	end
	return rel_paths
end

---@param dirname string
---@param files string[]
---@return string|nil error_message
local function cp_to_dir(dirname, files)
	-- TODO: make sure the directory dones't exist first
	local child, err = Command("mkdir"):args({ "-p", dirname }):spawn()
	if err then
		return "error while creating the mkdir child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the mkdir child: " .. err
	end

	local child, err = Command("cp"):args(files):arg(dirname):spawn()
	if err then
		return "error while creating the cp child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the cp child: " .. err
	end
end

---@param files string[]
---@return string|nil error_message
local function srm(files)
	local child, err = Command("srm"):args({ "-rf" }):args(files):spawn()
	if err then
		return "error while creating the srm child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the srm child: " .. err
	end
end

---@param file string
---@return string|nil error_message
local function gpg(file)
	local child, err = Command("gpg"):args({ "-r", "contact@omareloui.com", "-e", file }):spawn()
	if err then
		return "error while creating the gpg child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the gpg child: " .. err
	end

	return srm({ file })
end

---@param archive_name string
---@param files string[]
---@return string|nil error_message
local function tarxz(archive_name, files)
	local child, err = Command("tar"):args({ "-Jcvf", archive_name }):args(files):spawn()
	if err then
		return "error while creating the tar child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the tar child: " .. err
	end
end

---@param name string
---@param files string[]
---@param is_protected boolean
---@return string|nil error_message
local function zip(name, files, is_protected)
	local args = "-r"
	if is_protected then
		args = args .. "e"
	end

	local err = cp_to_dir(name, files)
  -- stylua: ignore
	if err then return err end

	local child, err = Command("zip"):args({ args, name, name }):args(files):spawn()
	if err then
		return "error while creating the tar child: " .. err
	end

	local _, err = child:wait()
	if err then
		return "error on running the tar child: " .. err
	end

	return srm({ name })
end

---@return "xz"|"xz.gpg"|"zip"|nil func
local function get_func()
	local funcs = {
		"xz",
		"xz.gpg",
		"zip",
		"pzip",
	}

	local cand = ya.which({
		cands = {
			{ on = "x", desc = "protected .tar.xz file" },
			{ on = "g", desc = "gpg protected .tar.xz.gpg file" },
			{ on = "z", desc = ".zip file" },
			{ on = "p", desc = "protected .zip file" },
		},
	})

	if not cand then
		return
	end

	return funcs[cand]
end

return {
	entry = function(_self, _args)
		local func = get_func()

		if not func then
			return
		end

		local archive_name, event = ya.input({
			title = "Archive name:",
			position = { "top-center", w = 40 },
			realtime = false,
		})

		local confirmed = event == 1
		archive_name = trim(archive_name)
		if not confirmed or archive_name == "" then
			return
		end

		local sel, err = get_selected()
    -- stylua: ignore
    if err then return ya.err(tostring(err)) end

		local cwd = get_cwd()
		local rel_sel, err = get_rel_paths(cwd, sel)
    -- stylua: ignore
    if err or not rel_sel then return ya.err(tostring(err)) end

		if func == "xz" then
			archive_name = archive_name .. ".tar.xz"
			local err = tarxz(archive_name, rel_sel)
      -- stylua: ignore
      if err then return ya.err(tostring(err)) end
		elseif func == "xz.gpg" then
			archive_name = archive_name .. ".tar.xz"

			local err = tarxz(archive_name, rel_sel)
      -- stylua: ignore
      if err then return ya.err(tostring(err)) end

			local err = gpg(archive_name)
      -- stylua: ignore
      if err then return ya.err(tostring(err)) end
		elseif func == "zip" then
			local err = zip(archive_name, rel_sel, false)
      -- stylua: ignore
      if err then return ya.err(tostring(err)) end
		elseif func == "pzip" then
			local err = zip(archive_name, rel_sel, true)
      -- stylua: ignore
      if err then return ya.err(tostring(err)) end
		end
	end,
}
