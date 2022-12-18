local wk = require("which-key")

wk.register(
  { ["<leader>"] = { c = {name = "Toggle comment", l = "Comment line" } } },
  { mode = "n" }
)

wk.register(
  { ["<leader>"] = { c = "Toggle comment" } },
  { mode = "v" }
)
