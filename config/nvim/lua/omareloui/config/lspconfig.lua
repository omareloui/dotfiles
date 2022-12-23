local lsconfig_present, lspconfig = pcall(require, "lspconfig")
local typescript_present, typescript = pcall(require, "typescript")

if not lsconfig_present or not typescript_present then
  return
end

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

--------------------------------- html and css ---------------------------------
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

---------------------------------- typescript ----------------------------------
-- better functions for typescript
-- typescript is a wrapper for lspconfig.tssrever for
typescript.setup {
  server = {
    root_dir = lspconfig.util.root_pattern "package.json",
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

------------------------------------- deno -------------------------------------
lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("mod.js", "mod.ts", "deno.json"),
  on_attach = on_attach,
  capabilities = capabilities,
}

------------------------------------- vue --------------------------------------
-- lspconfig.vuels.setup {
--   on_attach = function(client)
--     on_attach(client)
--   end,
--   capabilities = capabilities,
-- }

------------------------------------ volar -------------------------------------
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

------------------------------------ astro -------------------------------------
lspconfig.astro.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
