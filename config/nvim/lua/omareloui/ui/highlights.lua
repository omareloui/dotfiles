local c = require "omareloui.ui.palette"
local set = vim.api.nvim_set_hl

M = {}

M.general = function()
  set(0, "Comment", { default = true, italic = true })
  set(0, "NonText", { fg = c.surface1 })

  set(0, "TabLine", { bg = c.overlay1, fg = "gray", italic = true })
  set(0, "TabLineFill", { default = true, bg = c.overlay1 })
  set(0, "TabLineSel", { default = true, fg = "white", bold = true })

  set(0, "CursorLine", { default = true, bg = c.overlay0 })
  set(0, "CursorColumn", { default = true, bg = c.overlay0 })
end

M.cmp = function()
  set(0, "CmpItemMenu", { fg = c.subtext0 })
end

M.indent_backline = function()
  set(0, "IndentBlanklineChar", { fg = c.surface1 })
  set(0, "IndentBlanklineSpaceChar", { fg = c.surface0 })
  set(0, "IndentBlanklineContextChar", { fg = c.surface2 })
  set(0, "IndentBlanklineContextStart", { fg = c.surface0 })
end

return M