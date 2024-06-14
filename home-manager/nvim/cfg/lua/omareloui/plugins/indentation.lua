local ignore_on_filetypes = {
  "Trouble",
  "alpha",
  "dashboard",
  "help",
  "lazy",
  "lazyterm",
  "mason",
  "neo-tree",
  "neotest-summary",
  "notify",
  "toggleterm",
  "trouble",
}

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = ignore_on_filetypes,
      },
    },
    main = "ibl",
  },

  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    version = false,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ignore_on_filetypes,
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
