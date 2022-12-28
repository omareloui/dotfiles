return {
  -- Helpers {{{
  "lewis6991/impatient.nvim",
  { "nvim-lua/plenary.nvim", module = true },
  -- }}}

  -- Themes and Styles {{{
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000,
    config = function() require("omareloui.plugins.colorscheme") end },
  { "kyazdani42/nvim-web-devicons", config = function() require("omareloui.plugins.nvim-webdev-icons") end },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("omareloui.plugins.bufferline") end },
  -- }}}

  { "lukas-reineke/indent-blankline.nvim",
    config = function() require("omareloui.plugins.indent-blankline") end },

  { "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function() require "omareloui.plugins.treesitter" end },

  -- Git {{{
  { "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    config = function() require("omareloui.plugins.gitsigns") end },
  -- }}}

  -- LSP {{{
  { "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function() require "omareloui.plugins.mason" end },
  { "neovim/nvim-lspconfig", config = function() require "omareloui.plugins.lspconfig" end },
  "jose-elias-alvarez/typescript.nvim",

  { "folke/trouble.nvim", enable = false, dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function() require "omareloui.plugins.trouble" end },
  -- }}}

  -- Snippets {{{
  { "L3MON4D3/LuaSnip",
    dependencies = { "friendly-snippets", "nvim-cmp" },
    config = function() require "omareloui.plugins.luasnip" require "omareloui.config.snippets" end },
  { "rafamadriz/friendly-snippets", module = { "cmp", "cmp_nvim_lsp" }, event = "InsertEnter" },
  -- }}}

  -- Cmp {{{
  { "hrsh7th/nvim-cmp",
    dependencies = { "friendly-snippets" },
    config = function() require "omareloui.plugins.cmp" end,
  },
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

  -- formatter
  ["jose-elias-alvarez/null-ls.nvim"] = { dependencies = { "nvim-lspconfig" },
    config = function() require "omareloui.plugins.null-ls" end },
  -- }}}



  -- File managing, picker etc {{{
  { "kyazdani42/nvim-tree.lua",
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function() require("omareloui.config.mappings").nvimtree() end,
    config = function() require "omareloui.plugins.nvimtree" end },

  { "nvim-telescope/telescope.nvim", cmd = "Telescope",
    init = function() require("omareloui.config.mappings").telescope() end,
    config = function() require "omareloui.plugins.telescope" end },
  -- }}}

  -- Terminal {{{
  { "akinsho/toggleterm.nvim", tag = "*",
    init = require("omareloui.config.mappings").terminal,
    config = function() require "omareloui.plugins.toggleterm" end },
  -- }}}

  -- Window {{{
  "szw/vim-maximizer",
  -- }}}

  -- Sessiosn {{{
  { "rmagatti/auto-session", config = function() require "omareloui.plugins.auto-session" end },
  -- }}}

  -- Misc {{{
  -- alpha
  -- TODO: (the dependencies)
  -- { "goolord/alpha-nvim", dependencies = { "base46" }, config = function() require "omareloui.plugins.alpha" end },

  -- autopair
  { "windwp/nvim-autopairs", dependencies = "nvim-cmp", config = function() require("omareloui.plugins.autopairs") end },

  -- commment
  { "numToStr/Comment.nvim", module = "Comment", keys = { "gc", "gb" },
    init = function() require("omareloui.config.mappings").comments() end,
    config = function() require("omareloui.plugins.comment") end },

  -- which key
  { "folke/which-key.nvim", module = "which-key", keys = { "<leader>", '"', "'", "`" },
    config = function() require "omareloui.plugins.whichkey" end },

  -- surround
  { "kylechui/nvim-surround", config = function() require "omareloui.plugins.surround" end },

  -- undotree
  { "mbbill/undotree", config = function() require "omareloui.plugins.undotree" end },

  -- pretty fold
  { "anuvyklack/pretty-fold.nvim", config = function() require "omareloui.plugins.fold" end },

  -- multi cursor
  "mg979/vim-visual-multi",

  -- todo comments
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require "omareloui.plugins.todo-comments" end, },

  -- scrollbar
  { "petertriho/nvim-scrollbar", config = function() require "omareloui.config.scrollbar" end },

  -- colorizer
  { "norcalli/nvim-colorizer.lua", config = function() require "omareloui.config.colorizer" end },
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

  -- ["NvChad/nvim-colorizer.lua"] = {
  --   init = function()
  --     require("core.lazy_load").on_file_open "nvim-colorizer.lua"
  --   end,
  --   config = function()
  --     require("plugins.configs.others").colorizer()
  --   end,
  -- },
}
