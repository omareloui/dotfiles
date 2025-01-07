return {
  "akinsho/toggleterm.nvim",
  enable = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local present, toggleterm = pcall(require, "toggleterm")

    -- stylua: ignore
    if not present then return end

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
      local set_buf_keymap = vim.api.nvim_buf_set_keymap
      set_buf_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], { desc = "Close the terminal" })
      set_buf_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], { desc = "Close the terminal" })
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

    local set = require("omareloui.util.keymap").set
    set("<leader>gg", "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", "Open lazygit")
  end,
}
