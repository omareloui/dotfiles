local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities

lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  root_dir = function(startpath)
    local package_json_dir = lspconfig.util.root_pattern "package.json"(startpath)

    if not package_json_dir then
      return
    end

    local utils = require "omareloui.plugins.lsp.utils"

    if utils.has_in_package_json(package_json_dir, "tailwindcss") then
      return package_json_dir
    end

    return nil
  end,
}

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
