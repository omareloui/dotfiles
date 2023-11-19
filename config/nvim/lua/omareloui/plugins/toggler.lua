return {
  "nguyenvukhang/nvim-toggler",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  init = require("omareloui.config.mappings").toggler,
  opts = {
    remove_default_keybinds = true,
    inverses = {
      ["true"] = "false",
      ["True"] = "False",
      ["vim"] = "emacs",
    },
  },
}
