return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope" },
  config = true,
  keys =  require("omareloui.config.mappings").todo_comments
}
