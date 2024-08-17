return {
  {
    "echasnovski/mini.ai",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 50,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
    enabled = false,
  },

  {
    "echasnovski/mini.bracketed",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      quickfix = { suffix = "", options = {} },
    },
  },

  { "echasnovski/mini.operators", event = { "BufReadPost", "BufWritePost", "BufNewFile" }, opts = {} },
}
