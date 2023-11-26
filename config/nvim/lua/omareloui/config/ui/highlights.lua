local c = require "omareloui.config.ui.palette"
local set = vim.api.nvim_set_hl

local M = {}

function M.general()
  set(0, "Comment", { default = true, italic = true })
  set(0, "NonText", { fg = c.surface1 })

  set(0, "CursorLine", { default = true, bg = c.mantle })
  set(0, "CursorMatchWord", { bg = c.surface0 })

  set(0, "SnippetActiveChoice", { fg = c.blue, bg = c.mantle })
  set(0, "SnippetActiveInsert", { fg = c.magenta, bg = c.mantle })
end

return M
