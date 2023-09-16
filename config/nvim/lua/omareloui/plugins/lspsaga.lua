local M =
  { "glepnir/lspsaga.nvim", branch = "main", init = require("omareloui.config.mappings").lspsaga, enabled = false }

function M.config()
  local present, lspsaga = pcall(require, "lspsaga")

  if not present then
    return
  end

  lspsaga.setup {
    lightbulb = {
      enable = false,
      virtual_text = false,
    },
    symbol_in_winbar = { enable = false },
    rename = {
      quit = "<Esc>",
      exec = "<CR>",
      in_select = true,
    },
    code_action = {
      num_shortcut = true,
      keys = {
        quit = "<Esc>",
        exec = "<CR>",
      },
    },
    ui = {
      border = "rounded",
      colors = {
        normal_bg = "",
      },
    },
  }
end

return M
