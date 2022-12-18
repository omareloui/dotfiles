require("omareloui.set")
require("omareloui.remap")
require("omareloui.packer")

if not vim.g.vscode then
  require("omareloui.lsp")
  require("omareloui.plugins_config.autopairs")
  require("omareloui.plugins_config.cmp")
  require("omareloui.plugins_config.coc")
  require("omareloui.plugins_config.gitsigns")
  require("omareloui.plugins_config.sessions")
  require("omareloui.plugins_config.telescope")
  require("omareloui.plugins_config.treesitter")
  require("omareloui.plugins_config.whichkey")
end
