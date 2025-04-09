local M = {
  misc = {
    dots = "󰇘",
  },

  dap = {
    Stopped = "󰁕 ",
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = " ",
    LogPoint = ".>",
  },

  diagnostics = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
  },

  informative_diagnostics = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
  },

  diagnostics_virtuals = {
    prefix = "●",
  },

  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },

  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = " ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },

  bufferline = {
    modified = " ",
    diagnostics = " ",
  },

  incline = {
    modified = " ",
    diagnostics = " ",
  },

  lualine = {
    copilot = " ",
    diff = "",
    lsp = "󰆼 ",
  },
}

return M
