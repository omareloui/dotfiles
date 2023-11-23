local language_server_to_load = {
  "bash",
  "css",
  "docker",
  "emmet",
  "html",
  "json",
  "lua_ls",
  "markdown",
  "prisma",
  "rust",
  "tailwind",
  "typescript",
  "volar",
  "yaml",
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
      },
    },
  },

  config = function()
    local lspconfig_present, lspconfig = pcall(require, "lspconfig")
    local cmp_lsp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    if not lspconfig_present or not cmp_lsp_present then
      return
    end

    require("lspconfig.ui.windows").default_options.border = "rounded"

    local on_attach = function(_, bufnr)
      require("omareloui.config.mappings").lsp(bufnr)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local signs = require("omareloui.config.ui.icons").diagnostics
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        severity = vim.diagnostic.severity.WARN,
        source = true,
        prefix = require("omareloui.config.ui.icons").diagnostics_virtuals.prefix,
      },
      signs = true,
      severity_sort = true,
      float = { border = "rounded" },
    }

    -- Configure the servers themselves
    for _, lsp_server in ipairs(language_server_to_load) do
      require("omareloui.plugins.lsp.lang." .. lsp_server).setup(lspconfig, on_attach, capabilities)
    end
  end,
}
