return {
  "williamboman/mason.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = "Mason",
  build = ":MasonUpdate",
  config = function()
    local mason = require "mason"
    local mason_lspconfig = require "mason-lspconfig"
    local mason_tool_installer = require "mason-tool-installer"

    mason.setup {}

    mason_lspconfig.setup {
      ensure_installed = {
        "astro",
        "bashls",
        "cssls",
        "denols",
        "emmet_ls",
        "eslint",
        "html",
        "lua_ls",
        "marksman",
        "prismals",
        "tailwindcss",
        "tsserver",
        "volar",
        "yamlls",
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "cspell",
        "eslint_d",
        "gitlint",
        "luacheck",
        "markdownlint",
        "shellcheck",
        "yamllint",
        "markdownlint",
        "prettier",
        "prettierd",
        "shfmt",
        "stylua",
        "yamlfmt",
      },
    }
  end,
}
