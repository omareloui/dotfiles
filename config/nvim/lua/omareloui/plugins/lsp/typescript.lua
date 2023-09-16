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
    -- So it doesn't run with Deno files.
    single_file_support = false,

    -- Run the lsp only when package.json is found in root
    -- and don't run in nuxt/vue projects as Volar does the same job
    root_dir = function(startpath)
      local package_json_dir = lspconfig.util.root_pattern "package.json"(startpath)

      if
        not package_json_dir
        -- or lspconfig.util.root_pattern("nuxt.config*", "vue.config*")(startpath)
        -- or utils.has_in_package_json(package_json_dir, "vue")
        -- or utils.has_in_package_json(package_json_dir, "nuxt")
      then
        return
      end

      return package_json_dir
    end,

    on_attach = on_attach,
    capabilities = capabilities,
  },
}
