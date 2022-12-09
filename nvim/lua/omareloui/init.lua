require("omareloui.set")
require("omareloui.remap")
require("omareloui.packer")

if not vim.g.vscode then
  require("omareloui.lsp")
  require("omareloui.cmp")
  require("omareloui.telescope")
  require("omareloui.treesitter")
  require("omareloui.autopairs")
  require("omareloui.gitsigns")
end
