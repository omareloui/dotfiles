local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities
local utils = require "omareloui.plugins.lsp.utils"

lspconfig.volar.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  root_dir = function(startpath)
    local nuxt_or_vue_root = lspconfig.util.root_pattern("nuxt.config*", "vue.config*")(startpath)

    if nuxt_or_vue_root then
      return nuxt_or_vue_root
    end

    local package_json_dir = lspconfig.util.root_pattern "package.json"(startpath)
    if not package_json_dir then
      return
    end

    if utils.has_in_package_json(package_json_dir, "vue") or utils.has_in_package_json(package_json_dir, "nuxt") then
      return package_json_dir
    end

    return nil
  end,

  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
}
