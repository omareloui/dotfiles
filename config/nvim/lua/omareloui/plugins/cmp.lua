M = { "hrsh7th/nvim-cmp", dependencies = { "friendly-snippets" } }

M.config = function()
  local present, cmp = pcall(require, "cmp")

  if not present then
    return
  end

  -- TODO:
  -- require("base46").load_highlight "cmp"

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
      format = function(_, vim_item)
        local icons = require("omareloui.ui.icons").lspkind
        vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
        return vim_item
      end,
    },

    mapping = require("omareloui.config.mappings").cmp(cmp),

    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "spell" },
    },
  }

  cmp.setup(options)
end

return M
