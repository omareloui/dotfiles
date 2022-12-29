M = { "hrsh7th/nvim-cmp", dependencies = { "friendly-snippets" } }

M.config = function()
  local present, cmp = pcall(require, "cmp")

  if not present then
    return
  end

  vim.o.completeopt = "menu,menuone,noselect"

  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end

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
      completion = {
        border = border "CmpBorder",
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = border "CmpDocBorder",
      },
    },

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    formatting = {
      format = function(entry, vim_item)
        local icons = require("omareloui.ui.icons").lspkind
        local menu = {
          buffer = "buf",
          nvim_lsp = "LSP",
          nvim_lua = "api",
          luasnip = "snip",
          path = "path",
          spell = "spell",
        }
        vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
        vim_item.menu = string.format("[%s]", menu[entry.source.name])
        return vim_item
      end,
    },

    mapping = require("omareloui.config.mappings").cmp(cmp),

    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "spell" },
      { name = "buffer", keyword_length = 5 },
    },
  }

  require("omareloui.ui.highlights").cmp()

  cmp.setup(options)
end

return M
