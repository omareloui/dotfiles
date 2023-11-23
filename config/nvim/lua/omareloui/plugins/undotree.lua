return {
  "mbbill/undotree",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = { { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" } },
}
