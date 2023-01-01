local typescript_present, typescript = pcall(require, "typescript")

if not typescript_present then
  return
end

local lspconfig = require("omareloui.plugins.lsp.config").lspconfig
local on_attach = require("omareloui.plugins.lsp.config").on_attach
local capabilities = require("omareloui.plugins.lsp.config").capabilities
local utils = require "omareloui.plugins.lsp.utils"

typescript.setup {
  server = {
    root_dir = function(startpath)
      local package_json_dir = lspconfig.util.root_pattern "package.json"(startpath)

      if not package_json_dir then
        return
      end

      if
        not lspconfig.util.root_pattern("nuxt.config*", "vue.config*")(startpath)
        and not utils.has_in_package_json(package_json_dir, "vue")
        and not utils.has_in_package_json(package_json_dir, "nuxt")
      then
        return package_json_dir
      end

      return nil
    end,

    on_attach = on_attach,
    capabilities = capabilities,
  },
}
