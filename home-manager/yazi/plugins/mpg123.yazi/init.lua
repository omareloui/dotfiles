local M = {}

function M:peek()
	local child = Command("mpg123")
		:args({ tostring(self.area.w), tostring(self.file.url) })
		:stdout(Command.PIPED)
		:stderr(Command.NULL)
		:spawn()

	local limit = self.area.h
	local i, lines = 0, ""

	repeat
		local next, event = child:read_line()
		if event == 1 and next ~= "" then
			ya.err(tostring(next))
		elseif event ~= 0 then
			break
		end

		i = i + 1
		if i > self.skip then
			lines = lines .. next
		end
	until i >= self.skip + limit
end

return M
