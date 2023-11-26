return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    enabled = false,
  },

  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    enabled = false,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      local present, catppuccin = pcall(require, "catppuccin")

      -- stylua: ignore
      if not present then return end

      local opts = {
        -- transparent_background = true,
        flavour = "mocha",
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          gitsigns = true,
          harpoon = true,
          headlines = true,
          illuminate = true,
          fidget = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          dap = { enabled = true, enable_ui = true },
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      }

      catppuccin.setup(opts)
    end,
  },
}
