M = { "neovim/nvim-lspconfig" }

M.config = function()
  require "omareloui.plugins.lsp.html-css"

  require "omareloui.plugins.lsp.volar"
  require "omareloui.plugins.lsp.vue"
  require "omareloui.plugins.lsp.astro"

  require "omareloui.plugins.lsp.typescript"
  require "omareloui.plugins.lsp.deno"
  require "omareloui.plugins.lsp.lua"
end

return M