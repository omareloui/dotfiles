local M =
  { "glepnir/lspsaga.nvim", branch = "main", init = require("omareloui.config.mappings").lspsaga, enabled = true }

function M.config()
  local present, lspsaga = pcall(require, "lspsaga")

  if not present then
    return
  end

  local options = {
    lightbulb = {
      enable = false,
      virtual_text = false,
    },
    -- symbol_in_winbar = { enable = false },
    rename = {
      in_select = false,
      auto_save = true,
      keys = {
        quit = "<Esc>",
      },
    },
    code_action = {
      num_shortcut = true,
    },
    ui = {
      border = "rounded",
      colors = {
        normal_bg = "",
      },
    },
    finder = {
      methods = {
        tyd = "textDocument/typeDefinition",
      },
    },
  }

  lspsaga.setup(options)
end

return M
