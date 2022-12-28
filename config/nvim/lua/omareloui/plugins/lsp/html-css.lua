local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities


lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.cssls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.tailwindcss.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "less",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}
