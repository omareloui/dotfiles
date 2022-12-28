local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities

lspconfig.vuels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
