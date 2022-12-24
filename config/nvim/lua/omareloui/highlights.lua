local M = {}

M.override = {
  Comment = { italic = true },
}

M.add = {
  TabLine = { bg = "black2", fg = "gray", italic = true },
  TabLineFill = { bg = "black2" },
  TabLineSel = { fg = "white", bold = true },

  CursorLine = { bg = "black" },
  CursorColumn = { bg = "black" },
}

return M
