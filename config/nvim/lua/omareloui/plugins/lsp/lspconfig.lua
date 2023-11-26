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
      local d = vim.diagnostic
      local l = vim.lsp

      local function set(lhs, rhs, desc, mode)
        return require("omareloui.util.keymap").set(lhs, rhs, desc, { mode = mode })
      end

      set("K", l.buf.hover, "Show documentation for what is under cursor")
      set("gt", l.buf.type_definition, "Lsp definition type")
      set("gi", l.buf.implementation, "Lsp definition type")
      set("gd", l.buf.definition, "Lsp definition")
      set("gD", l.buf.declaration, "Go to declaration")
      set("gR", "<Cmd>Telescope lsp_references<CR>", "Show LSP references")
      set("<leader>ls", l.buf.signature_help, "Lsp signature_help")
      set("<leader>rs", "<Cmd>LspRestart<CR>", "Restart the lsp server")
      set("<leader>v", "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Restart the lsp server")
      set("<leader>rn", l.buf.rename, "Smart rename")
      set("<leader>ca", l.buf.code_action, "See available code actions", { "n", "v" })

      set("<leader>lwa", l.buf.add_workspace_folder, "Add lsp workspace folder")
      set("<leader>lwr", l.buf.remove_workspace_folder, "Remove lsp workspace folder")
      set("<leader>lwl", l.buf.list_workspace_folders, "List lsp workspace folders")

      set("<leader>?", d.open_float, "Floating diagnostic")
      set("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
      set("[d", d.goto_prev, "Go to previous diagnostic")
      set("]d", d.goto_next, "Go to next diagnostic")

      local wk = require "which-key"
      wk.register({
        c = "+code actions",
        r = "+rename and restart",
        l = "+lsp and linters",
      }, { prefix = "<leader>" })
      wk.register({ w = "+workspace" }, { prefix = "<leader>l" })
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
