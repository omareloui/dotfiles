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
  },

  config = function()
    local ok, lspsaga = pcall(require, "lspsaga")

    -- stylua: ignore
    if not ok then return end

    local set = require("omareloui.util.keymap").set
    set("K", "<Cmd>Lspsaga hover_doc<CR>", "Show documentation for what is under cursor")

    local opts = {}
    lspsaga.setup(opts)
  end,
}
