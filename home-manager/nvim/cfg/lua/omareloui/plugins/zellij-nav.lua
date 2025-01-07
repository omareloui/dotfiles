return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<Cmd>ZellijNavigateLeftTab<CR>", { silent = true, desc = "Navigate left or tab" } },
    { "<C-j>", "<Cmd>ZellijNavigateDown<CR>", { silent = true, desc = "Navigate down" } },
    { "<C-k>", "<Cmd>ZellijNavigateUp<CR>", { silent = true, desc = "Navigate up" } },
    { "<C-l>", "<Cmd>ZellijNavigateRightTab<CR>", { silent = true, desc = "Navigate right or tab" } },
  },
  opts = {},
}
