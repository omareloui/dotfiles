local c = require "omareloui.ui.palette"
local set = vim.api.nvim_set_hl

M = {}

M.general = function()
  set(0, "Comment", { default = true, italic = true })
  set(0, "NonText", { fg = c.surface1 })

  set(0, "TabLine", { bg = c.overlay1, fg = "gray", italic = true })
  set(0, "TabLineFill", { default = true, bg = c.overlay1 })
  set(0, "TabLineSel", { default = true, fg = "white", bold = true })

  set(0, "CursorLine", { default = true, bg = c.mantle })
  set(0, "CursorMatchWord", { bg = c.surface0 })

  set(0, "SnippetActiveChoice", { fg = c.blue, bg = c.mantle })
  set(0, "SnippetActiveInsert", { fg = c.magenta, bg = c.mantle })

  set(0, "Folded", { fg = c.subtext1, bg = c.crust })
end

M.cmp = function()
  set(0, "CmpItemMenu", { fg = c.subtext0 })
end

M.indent_backline = function()
  set(0, "RainbowRed", { fg = c.red })
  set(0, "RainbowYellow", { fg = c.light_yellow })
  set(0, "RainbowBlue", { fg = c.light_blue })
  set(0, "RainbowOrange", { fg = c.yellow })
  set(0, "RainbowGreen", { fg = c.light_green })
  set(0, "RainbowViolet", { fg = c.magenta })
  set(0, "RainbowCyan", { fg = c.cyan })
end

M.gitsings = function()
  set(0, "DiffAdd", { fg = c.green })
  set(0, "DiffAdded", { fg = c.green })
  set(0, "DiffChange", { fg = c.blue })
  set(0, "DiffChangeDelete", { fg = c.red })
  set(0, "DiffModified", { fg = c.light_yellow })
  set(0, "DiffDelete", { fg = c.red })
  set(0, "DiffRemoved", { fg = c.red })
end

function M.ufo()
  set(0, "UfoFoldedFg", { link = "Comment" })
  set(0, "UfoFoldedBg", { link = "Folded" })
end

return M
