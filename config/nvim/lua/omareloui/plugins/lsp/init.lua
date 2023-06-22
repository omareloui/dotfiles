local M = { "neovim/nvim-lspconfig", dependencies = { "williamboman/mason.nvim" }, event = "BufReadPre" }

function M.config()
  require "mason"
  require("omareloui.plugins.lsp.config").diagnostics_setup()

  require "omareloui.plugins.lsp.html-css"

  require "omareloui.plugins.lsp.volar"
  require "omareloui.plugins.lsp.astro"

  require "omareloui.plugins.lsp.typescript"
  require "omareloui.plugins.lsp.deno"
  require "omareloui.plugins.lsp.rust"
  require "omareloui.plugins.lsp.lua"

  require "omareloui.plugins.lsp.bashls"
  require "omareloui.plugins.lsp.prisma"
end

return M
