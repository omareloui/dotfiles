local wk = require("which-key")

-- TODO: complete this file
wk.register(
  { ["<leader>"] = { ["/"] = "Comment the line" } },
  { mode = "n" }
)

wk.register(
  { ["<leader>"] = { name = "Comment", ["/"] = "<Cmd>'<,'>CommentToggle<CR>" } },
  { mode = "v" }
)
