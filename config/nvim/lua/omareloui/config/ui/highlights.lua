local c = require "omareloui.config.ui.palette"
local set = vim.api.nvim_set_hl

local M = {}

function M.general()
  set(0, "Comment", { default = true, italic = true })
  set(0, "NonText", { fg = c.surface1 })
end

return M
