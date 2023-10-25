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
    "RainbowBlue",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
    "RainbowOrange",
    "RainbowRed",
    "RainbowYellow",
  }

  local hooks = require "ibl.hooks"

  hooks.register(hooks.type.HIGHLIGHT_SETUP, require("omareloui.ui.highlights").indent_backline)

  local options = {
    exclude = {
      buftypes = { "terminal" },
      filetypes = {
        "help",
        "terminal",
        "alpha",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
      },
    },

    scope = {
      enabled = true,
      highlight = highlight,
      show_start = true,
      priority = 500,
      show_end = true,
    },
  }

  ibl.setup(options)
end

return M
