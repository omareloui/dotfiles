local typescript_present, typescript = pcall(require, "typescript")

if not typescript_present then
  return
end

local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities

typescript.setup {
  server = {
    root_dir = lspconfig.util.root_pattern "package.json",
    on_attach = on_attach,
    capabilities = capabilities,
  },
}
