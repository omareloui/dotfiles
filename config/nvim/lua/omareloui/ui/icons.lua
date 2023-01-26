local M = {}

M.separator = {
  round = { right = "", left = "" },
  empty_round = { left = "", right = "" },
}

M.diagnostics = {
  -- Error = " ",
  -- Warn = " ",
  -- Hint = " ",
  -- Info = " ",

  Error = "●",
  Warn = "●",
  Hint = "●",
  Info = "●",

  -- ﱢ       ●
  virtual_prefix = "",
}

M.lualine = {
  --                                            ﲤ      ﴱ   h
  vim_icon = "",
  diff = { added = " ", modified = " ", removed = " " },
  location = "",
  progress = "",
  lsp = "",
  copilot = "",
}

M.lspkind = {
  Namespace = "",
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = " ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
  Copilot = " ",
}

return M
