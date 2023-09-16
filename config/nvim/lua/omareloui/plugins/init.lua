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
  { "folke/trouble.nvim", config = true, enabled = false },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    opts = { text = { spinner = "dots" }, window = { blend = 0 } },
    enabled = false,
  },
  { "Fymyte/rasi.vim", ft = "rasi", enabled = false },
  { "elkowar/yuck.vim", enabled = false },
  -- }}}

  -- Treesitter {{{
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "nvim-treesitter/nvim-treesitter-textobjects",
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
    enabled = false,
  },
  -- }}}

  -- Backend helpers {{{
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        enabled = true,
        timeout = 50,
      },
    },
    init = require("omareloui.config.mappings").rest,
    enabled = false,
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
  { "rmagatti/auto-session", opts = { auto_restore_enabled = false }, enabled = false },
  -- }}}

  -- Misc {{{
  -- comment
  {
    "numToStr/Comment.nvim",
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
  -- { "anuvyklack/pretty-fold.nvim", config = { fill_char = "-" }, enabled = false },

  -- multi cursor
  { "mg979/vim-visual-multi", enabled = false },

  -- todo comments
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

  -- scrollbar
  { "petertriho/nvim-scrollbar", config = true, enabled = false },

  -- tabout
  { "abecodes/tabout.nvim", dependencies = { "nvim-treesitter", "nvim-cmp" }, config = true, enabled = false },

  -- context vt
  { "haringsrob/nvim_context_vt", opts = { prefix = " »" }, enabled = false },
  -- }}}

  -- Games {{{
  { "ThePrimeagen/vim-be-good", enabled = false },
  -- }}}
}
