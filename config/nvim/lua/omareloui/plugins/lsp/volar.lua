local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities

-- requires to install it manually (doesn't exist on Mason)
-- npm install -g @volar/vue-language-server
-- Volar can serve as a language server for
-- both Vue and TypeScript via Take Over Mode.

lspconfig.volar.setup {
  -- TODO: activate only if found vue or nuxt installed in package.json
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
}
