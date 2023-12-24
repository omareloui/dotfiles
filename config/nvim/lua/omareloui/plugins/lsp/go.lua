return {
  "olexsmir/gopher.nvim",
  ft = { "go" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>ct", "<Cmd>GoTagAdd<CR>", desc = "Add json/yaml tags" },
    { "<leader>cr", "<Cmd>GoTagRm<CR>", desc = "Remove json/yaml tags" },
    { "<leader>ci", "<Cmd>GoIfErr<CR>", 'Generate "if err" boilerplate' },
  },
  opts = {},
}
