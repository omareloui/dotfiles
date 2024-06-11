return {
  "hrsh7th/nvim-cmp",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "rafamadriz/friendly-snippets",
    "Exafunction/codeium.nvim",
    "onsails/lspkind.nvim",
    { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
  },

  config = function()
    local present, cmp = pcall(require, "cmp")

    -- stylua: ignore
    if not present then return end

    local lspkind = require "lspkind"
    local cmp_window = require "cmp.utils.window"
    local defaults = require "cmp.config.default"()

    cmp_window.info_ = cmp_window.info
    cmp_window.info = function(self)
      local info = self:info_()
      info.scrollable = false
      return info
    end

    local options = {
      experimental = { ghost_text = true },
      completion = {
        completeopt = "menu,menuone,preview,noinsert",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_car = "",
        },
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
      },
      sources = cmp.config.sources({
        { name = "codeium" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "crates" },
        { name = "luasnip" },
        { name = "path" },
        { name = "spell" },
      }, { { name = "buffer" } }),
      sorting = defaults.sorting,
    }

    cmp.setup(options)
  end,
}
