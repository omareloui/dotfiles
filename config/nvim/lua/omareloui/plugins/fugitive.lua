return {
  "tpope/vim-fugitive",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    { "<leader>gl", "<Cmd>GcLog -10<CR>", desc = "Git logs" },
    { "<leader>gfl", "<Cmd>Git log -p --follow -- %<CR>", desc = "Git file log" },
  },
}
