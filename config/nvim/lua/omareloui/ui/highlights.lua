local mocha = require("catppuccin.palettes").get_palette "mocha"

local color_scheme = mocha

M = {}

-- TODO:
M.general = function()
  vim.api.nvim_set_hl(0, "Comment", { default = true, italic = true })
  -- :h nvim_set_hl
  -- vim.api.nvim_set_hl()

  -- M.override = {
  --   Comment = { italic = true },
  -- }

  -- M.add = {
  --   TabLine = { bg = "black2", fg = "gray", italic = true },
  --   TabLineFill = { bg = "black2" },
  --   TabLineSel = { fg = "white", bold = true },

  --   CursorLine = { bg = "black" },
  --   CursorColumn = { bg = "black" },
  -- }
end

M.cmp = function()
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = color_scheme.subtext0 })
end

return M
