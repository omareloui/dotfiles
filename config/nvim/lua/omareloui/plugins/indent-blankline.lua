local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  enabled = true,
}

M.config = function()
  local present, ibl = pcall(require, "ibl")

  if not present then
    return
  end

  local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
  }

  local hooks = require "ibl.hooks"

  hooks.register(hooks.type.HIGHLIGHT_SETUP, require("omareloui.ui.highlights").indent_backline)

  local options = {
    scope = { highlight = highlight, show_start = false, show_end = false },
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = false,
  }

  ibl.setup(options)
end

return M
