M = { "akinsho/toggleterm.nvim", tag = "*", init = require("omareloui.config.mappings").terminal }

M.config = function()
  local present, toggleterm = pcall(require, "toggleterm")

  if not present then
    return
  end

  toggleterm.setup {
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

  -- local node = Terminal:new { cmd = "node", hidden = true }
  -- function _NODE_TOGGLE()
  --   node:toggle()
  -- end

  -- local htop = Terminal:new { cmd = "htop", hidden = true }
  -- function _HTOP_TOGGLE()
  --   htop:toggle()
  -- end
end

return M
