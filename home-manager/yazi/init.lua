---@param s string
---@return string
local function trim(s)
	return s:match("^%s*(.-)%s*$")
end

---@param str string
---@param start string
---@return boolean
local function starts_with(str, start)
	return str:sub(1, #start) == start
end

local old_linemode = Folder.linemode
function Folder:linemode(area, _files)
	if cx.active.conf.linemode ~= "mylinemode" then
		return old_linemode(self, area)
	end

	local lines = {}

	local year = os.date("%Y")

	for _, f in ipairs(self:by_kind(self.CURRENT).window) do
		-- Modified time
		local time = math.floor(f.cha.modified)
		if time and os.date("%Y", time) ~= year then
			time = os.date("%d %b. %Y", time)
		else
			time = time and os.date("%d %b. %H:%M", time) or ""
		end

		-- Size
		local size = f:size()
		size = size and ya.readable_size(size):gsub(" ", "") or "-"

		lines[#lines + 1] = ui.Line({
			ui.Span(" "),
			ui.Span(size),
			ui.Span("   "),
			ui.Span(time),
			ui.Span(" "),
		})
	end

	return ui.Paragraph(area, lines):align(ui.Paragraph.RIGHT)
end

function Status:mime()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" or h.cha.is_dir then
		return ui.Line({})
	end

	local mime = h:mime()

	if not mime then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(" "),
		ui.Span(mime):fg("gray"):dim(),
	})
end

function Status:owner()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(" "),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(" "),
	})
end

function Status:render(area)
	self.area = area

	local left = ui.Line({ self:mode(), self:size(), self:name() })
	local right = ui.Line({ self:mime(), self:owner(), self:permissions(), self:percentage(), self:position() })

	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end
