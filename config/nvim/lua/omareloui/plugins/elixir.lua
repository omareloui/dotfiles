local M = {
  "elixir-tools/elixir-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  event = "BufReadPre",
  filetypes = { "elixir" },
  enabled = false,
}

M.config = function()
  local present, elixir = pcall(require, "elixir")

  local my_lspconfigs = require "omareloui.plugins.lsp.config"

  local on_attach = my_lspconfigs.on_attach
  local capabilities = my_lspconfigs.capabilities

  if not present then
    return
  end

  local elixirls = require "elixir.elixirls"

  elixir.setup {
    credo = {
      enable = true,
    },
    elixirls = {
      enable = true,
      filetypes = { "elixir" },
      on_attach = on_attach,
      capabilities = capabilities,
    },
  }
end

return M
