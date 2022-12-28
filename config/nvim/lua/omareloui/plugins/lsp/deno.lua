local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities

lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("mod.js", "mod.ts", "deno.json"),
  on_attach = on_attach,
  capabilities = capabilities,
}
