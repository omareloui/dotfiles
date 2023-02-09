vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "omareloui.config.options"
require "omareloui.config.lazy"
require("omareloui.ui.highlights").general()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require "omareloui.config.commands"
    require "omareloui.config.mappings"
  end,
})
