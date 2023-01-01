local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities

lspconfig.astro.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  root_dir = function(startpath)
    local package_json_dir = lspconfig.util.root_pattern "package.json"(startpath)

    if not package_json_dir then
      return
    end

    local utils = require "omareloui.plugins.lsp.utils"
    if utils.has_in_package_json(package_json_dir, "astro") then
      return package_json_dir
    end

    return nil
  end,
}
