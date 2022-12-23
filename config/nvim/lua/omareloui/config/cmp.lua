local cmp = require "cmp"

return {
  experimental = { ghost_text = true },

  sources = {
    { name = "nvim_lua" },

    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "spell" },
  },

  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-c>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>luasnip-expand-or-jump",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>luasnip-jump-prev",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}
