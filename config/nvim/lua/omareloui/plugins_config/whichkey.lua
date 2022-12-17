local wk = require("which-key")

-- TODO: complete this file
wk.register(
  { ["<leader>"] = { ["/"] = "Toggle comment" } },
  { mode = "n" }
)

wk.register(
  { ["<leader>"] = { ["/"] = "Toggle comment" } },
  { mode = "v" }
)
