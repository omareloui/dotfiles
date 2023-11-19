local M = { "akinsho/toggleterm.nvim", event = { "BufReadPost", "BufWritePost", "BufNewFile" } }

M.config = function()
  local present, toggleterm = pcall(require, "toggleterm")

  if not present then
    return
  end

  require("omareloui.config.mappings").terminal()

  local opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }

  toggleterm.setup(opts)

  function _G.set_terminal_keymaps()
    require("omareloui.config.mappings").terminal_when_active()
  end

  vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

  local Terminal = require("toggleterm.terminal").Terminal

  local terminal = Terminal:new { hidden = true }
  function _TERMINAL_TOGGLE()
    terminal:toggle()
  end

  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end
end

return M
