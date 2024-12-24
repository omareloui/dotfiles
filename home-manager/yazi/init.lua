-- LINE MODE --
function Linemode:custom()
	local year = os.date("%Y")
	local time = math.floor(self._file.cha.mtime or 0)

	if time and os.date("%Y", time) ~= year then
		time = os.date("%d %b. %Y", time)
	else
		time = time and os.date("%d %b. %H:%M", time) or ""
	end

	local size = self._file:size()
	return ui.Line(string.format(" %s %s ", size and ya.readable_size(size):gsub(" ", "") or "-", time))
end

-- STATUS BAR --
local function status_mimetype()
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

local function status_owner()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end
	return ui.Line({
		ui.Span(" "),
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	})
end

Status:children_add(status_mimetype, 400, Status.RIGHT)
Status:children_add(status_owner, 500, Status.RIGHT)
