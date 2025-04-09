return {
  "tpope/vim-fugitive",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    { "<leader>gl", "<Cmd>GcLog -10<CR>", desc = "Git logs" },
    { "<leader>gp", "<Cmd>Git push<CR>", desc = "Push to origin" },
    { "<leader>gfl", "<Cmd>Git log -p --follow -- %<CR>", desc = "Git file log" },
  },
}
