return {
  "nvimdev/lspsaga.nvim",
  enabled = false,
  event = "BufEnter",
  after = "nvim-lspconfig",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "Show documentation for what is under cursor" },
    { "<leader>?", "<Cmd>Lspsaga diagnostic_jumbp_next<CR>", desc = "Show floating diagnostic" },
    { "<leader>D", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "Show buffer diagnostics" },
    { "[d", "<Cmd>Lspsaga diagnostic_jumbp_prev<CR>", desc = "Go to previous diagnostic" },
    { "]d", "<Cmd>Lspsaga diagnostic_jumbp_next<CR>", desc = "Go to next diagnostic" },
    {
      "[D",
      function()
        require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.WARN }
      end,
      desc = "Go to previous diagnostic error",
    },
    {
      "]D",
      function()
        require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.WARN }
      end,
      desc = "Go to next diagnostic error",
    },
    { "gR", "<Cmd>Lspsaga finder ref+imp<CR>", desc = "Show LSP references" },
    { "<leader>rn", "<Cmd>Lspsaga rename<CR>", desc = "Smart rename" },
  },

  opts = {
    symbols_in_winbar = { enable = false },
    lightbulb = { enable = false },
    finder = {
      keys = {
        vsplit = "v",
        split = "h",
      },
    },
    rename = { auto_save = true, keys = { quit = "<Esc>" } },
    border = "rounded",
    scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
  },
}
