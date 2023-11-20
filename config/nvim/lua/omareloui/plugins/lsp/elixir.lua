return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local present, elixir = pcall(require, "elixir")

    if not present then
      return
    end

    local elixirls = require "elixir.elixirls"

    elixir.setup {
      nextls = { enable = true },
      credo = { enable = true },
      elixirls = {
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = false,
        },
        on_attach = function()
          require("omareloui.config.mappings").lsp()
          require("omareloui.config.mappings").elixir()
        end,
      },
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
