return {
  -- Helpers {{{
  "lewis6991/impatient.nvim",
  { "nvim-lua/plenary.nvim", module = true },
  -- }}}

  -- Themes and Styles {{{
  { "akinsho/bufferline.nvim", tag = "v3.*", config = true, init = require("omareloui.config.mappings").bufferline },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000,
    config = function() vim.cmd.colorscheme "catppuccin-mocha" end },
  -- }}}

  -- LSP {{{
  "jose-elias-alvarez/typescript.nvim",
  { "folke/trouble.nvim", config = true },
  -- }}}

  -- Snippets {{{
  { "rafamadriz/friendly-snippets", module = { "cmp", "cmp_nvim_lsp" }, event = "InsertEnter" },
  -- }}}

  -- Cmp {{{
  { "saadparwaiz1/cmp_luasnip", dependencies = { "LuaSnip" } },
  { "hrsh7th/cmp-nvim-lua", dependencies = { "cmp_luasnip" } },
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "cmp-nvim-lua" } },
  { "hrsh7th/cmp-buffer", dependencies = { "cmp-nvim-lsp" } },
  { "hrsh7th/cmp-path", dependencies = { "cmp-buffer" } },
  "f3fora/cmp-spell",
  -- }}}

  -- Linters and formatters {{{
  -- editorconfig
  "gpanders/editorconfig.nvim",
  -- }}}

  -- Window {{{
  "szw/vim-maximizer",
  -- }}}

  -- Sessiosn {{{
  { "rmagatti/auto-session", config = { auto_restore_enabled = false, } },
  -- }}}

  -- Misc {{{
  -- commment
  { "numToStr/Comment.nvim", module = "Comment", keys = { "gc", "gb" },
    init = require("omareloui.config.mappings").comments, config = true },

  -- surround
  { "kylechui/nvim-surround", config = true },

  -- undotree
  { "mbbill/undotree", init = require("omareloui.config.mappings").undotree },

  -- pretty fold
  { "anuvyklack/pretty-fold.nvim", config = { fill_char = "-" } },

  -- multi cursor
  "mg979/vim-visual-multi",

  -- todo comments
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

  -- scrollbar
  { "petertriho/nvim-scrollbar", config = true },
  -- }}}



  -- TODO:
  --   ["NvChad/extensions"] = { module = { "telescope", "nvchad" } },
  --   ["NvChad/base46"] = {
  --     config = function()
  --       local ok, base46 = pcall(require, "base46")

  --       if ok then
  --         base46.load_theme()
  --       end
  --     end,
  --   },
  -- --
  --   ["NvChad/ui"] = {
  --     dependencies = {"base46"},
  --     config = function()
  --       local present, nvchad_ui = pcall(require, "nvchad_ui")

  --       if present then
  --         nvchad_ui.setup()
  --       end
  --     end,
  --   },

  --   ["NvChad/nvterm"] = {
  --     module = "nvterm",
  --     config = function()
  --       require "plugins.configs.nvterm"
  --     end,
  --     init = function()
  --       require("core.utils").load_mappings "nvterm"
  --     end,
  --   },
}
