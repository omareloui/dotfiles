return {
  -- Helpers {{{
  "lewis6991/impatient.nvim",
  { "nvim-lua/plenary.nvim", module = true },
  -- }}}

  -- Themes and Styles {{{
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    opts = {
      hide = {
        virtual_text = false,
        signs = false,
        underline = true,
      },
    },
  },
  -- }}}

  -- LSP {{{
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  "jose-elias-alvarez/typescript.nvim",
  "simrat39/rust-tools.nvim",
  { "folke/trouble.nvim", config = true },
  { "j-hui/fidget.nvim", opts = { text = { spinner = "dots" }, window = { blend = 0 } } },
  { "Fymyte/rasi.vim", ft = "rasi" },
  { "elkowar/yuck.vim" },
  -- }}}

  -- Treesitter {{{
  "nvim-treesitter/nvim-treesitter-textobjects",
  "windwp/nvim-ts-autotag",
  "p00f/nvim-ts-rainbow",
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

  -- Previewer {{{
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- }}}

  -- Linters and formatters {{{
  -- editorconfig
  "gpanders/editorconfig.nvim",
  -- }}}

  -- Window {{{
  "szw/vim-maximizer",
  -- }}}

  -- Telescope {{{
  "nvim-telescope/telescope-file-browser.nvim",
  --- }}}

  -- Session {{{
  { "rmagatti/auto-session", opts = { auto_restore_enabled = false } },
  -- }}}

  -- Misc {{{
  -- comment
  {
    "numToStr/Comment.nvim",
    module = "Comment",
    init = require("omareloui.config.mappings").comments,
    opts = {
      mappings = false,
      ignore = "^(%s*)$", -- ignore empty/spaces only lines
    },
  },

  -- surround
  { "kylechui/nvim-surround", config = true },

  -- undotree
  { "mbbill/undotree", init = require("omareloui.config.mappings").undotree },

  -- pretty fold
  -- { "anuvyklack/pretty-fold.nvim", config = { fill_char = "-" } },

  -- multi cursor
  "mg979/vim-visual-multi",

  -- todo comments
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

  -- scrollbar
  { "petertriho/nvim-scrollbar", config = true },

  -- tabout
  { "abecodes/tabout.nvim", dependencies = { "nvim-treesitter", "nvim-cmp" }, config = true },

  -- context vt
  { "haringsrob/nvim_context_vt", opts = { prefix = " »" } },
  -- }}}

  -- Games {{{
  "ThePrimeagen/vim-be-good",
  -- }}}
}
