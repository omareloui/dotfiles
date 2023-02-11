local M = { "nguyenvukhang/nvim-toggler", init = require("omareloui.config.mappings").toggler }

M.opts = {
  remove_default_keybinds = true,
  inverses = {
    ["True"] = "False",
    ["vim"] = "emacs",
  },
}

return M
