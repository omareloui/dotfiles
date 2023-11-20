return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "rafamadriz/friendly-snippets",
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
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
            buffer = "buf",
            spell = "spell",
          }
          vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
          vim_item.menu = string.format("[%s]", menu[entry.source.name])
          require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert(require("omareloui.config.mappings").cmp(cmp)),
      sources = {
        {
          name = "nvim_lsp",
          entry_filter = function(entry)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
          end,
        },
        { name = "nvim_lua" },
        { name = "crates" },
        { name = "luasnip" },
        { name = "path" },
        { name = "spell" },
        { name = "buffer", keyword_length = 5 },
      },
    }

    require("omareloui.config.ui.highlights").cmp()

    cmp.setup(options)
  end,
}
