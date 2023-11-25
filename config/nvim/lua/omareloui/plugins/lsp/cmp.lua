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
    { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      opts = {
        src = {
          cmp = { enabled = true },
        },
      },
    },
  },

  config = function()
    local present, cmp = pcall(require, "cmp")

    if not present then
      return
    end

    vim.o.completeopt = "menu,menuone,preview,noselect"

    local cmp_window = require "cmp.utils.window"

    cmp_window.info_ = cmp_window.info
    cmp_window.info = function(self)
      local info = self:info_()
      info.scrollable = false
      return info
    end

    local function ignore_text(entry)
      return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
    end

    local options = {
      experimental = { ghost_text = true },
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
        format = function(entry, vim_item)
          local icons = require("omareloui.config.ui.icons").kinds
          local menu = {
            nvim_lsp = "LSP",
            nvim_lua = "api",
            luasnip = "snip",
            path = "path",
            spell = "spell",
            codeium = "codeium",
            buffer = "file",
          }
          vim_item.menu = string.format("[%s]", menu[entry.source.name])
          vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
          require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
      },
      sources = cmp.config.sources {
        { name = "codeium" },
        { name = "nvim_lsp", filter = ignore_text },
        { name = "nvim_lua" },
        { name = "crates" },
        { name = "luasnip" },
        { name = "path" },
        { name = "spell" },
        { name = "buffer", keyword_length = 3 },
      },
    }

    require("omareloui.config.ui.highlights").cmp()

    cmp.setup(options)
  end,
}
