local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "omareloui.lsp.mason"
require("omareloui.lsp.handlers").setup()
require "omareloui.lsp.null-ls"
