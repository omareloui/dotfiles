local M = {}

M.override = {
  CursorLine = {
    bg = "black2",
  },
  Comment = {
    italic = true,
  },
}

M.add = {
  TabLine = { bg = "black2", fg = "gray", italic = true },
  TabLineFill = { bg = "black2" },
  TabLineSel = { fg = "white", bold = true },
}

return M
