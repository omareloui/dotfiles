M = {
  ------- override configs -------

  -- enable alpha nvim
  ["goolord/alpha-nvim"] = {
    disable = false,
    override_options = require "omareloui.config.alpha",
  },

  -- enable which key
  ["folke/which-key.nvim"] = {
    disable = false,
  },

  -- disable the default terminal
  ["NvChad/nvterm"] = {
    disable = true,
  },

  -- override nvimtree configs
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = function()
      return require "omareloui.config.nvim_tree"
    end,
  },

  -- override treesitter config
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = "all",
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<TAB>",
          node_incremental = "<CR>",
          node_decremental = "<S-TAB>",
        },
      },
    },
  },

  -- add lsp config
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "astro-language-server",
        "css-lsp",
        "deno",
        "eslint-lsp",
        "eslint_d",
        "lua-language-server",
        "luacheck",
        "luaformatter",
        "luau-lsp",
        "markdownlint",
        "prettier",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
        "vue-language-server",
      },
    },
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "omareloui.config.lspconfig"
    end,
  },

  -- add config to cmp
  ["hrsh7th/nvim-cmp"] = {
    override_options = function()
      return require "omareloui.config.cmp"
    end,
  },

  -- snippets
  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    override_options = function()
      local types = require "luasnip.util.types"
      return {
        enable_autosnippets = true,
        [types.choiceNode] = {
          active = {
            virt_text = { { " Current choice" } },
          },
        },
      }
    end,
    config = function()
      require("plugins.configs.others").luasnip()
      require "omareloui.snippets"
    end,
  },

  --------------------------------- my plugins ---------------------------------

  -- telescope
  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      return require "omareloui.config.telescope"
    end,
  },

  -- telescope extensions
  ["nvim-telescope/telescope-file-browser.nvim"] = {},

  -- toggle terminal
  ["akinsho/toggleterm.nvim"] = {
    tag = "*",
    config = function()
      require "omareloui.config.terminal"
    end,
  },

  -- cmp
  ["f3fora/cmp-spell"] = {},

  -- lsp
  ["jose-elias-alvarez/typescript.nvim"] = {},

  -- formatter
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "omareloui.config.null_ls"
    end,
  },

  -- editorconfig
  ["gpanders/editorconfig.nvim"] = {},

  -- surround
  ["kylechui/nvim-surround"] = {
    tag = "*",
    config = function()
      require "omareloui.config.surround"
    end,
  },

  -- undotree
  ["mbbill/undotree"] = {
    config = function()
      require "omareloui.config.undotree"
    end,
  },

  -- fold
  ["anuvyklack/pretty-fold.nvim"] = {
    config = function()
      require "omareloui.config.fold"
    end,
  },

  -- git
  ["tpope/vim-fugitive"] = {
    disable = true,
  },

  -- persist the vim session
  ["rmagatti/auto-session"] = {
    config = function()
      require "omareloui.config.auto_session"
    end,
  },

  -- multi cursor
  ["mg979/vim-visual-multi"] = {},

  -- window related plugins
  ["christoomey/vim-tmux-navigator"] = {},
  ["szw/vim-maximizer"] = {},

  -- for my todos
  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "omareloui.config.todo_comments"
    end,
  },

  -- trouble (show problems of the file in a bar)
  ["folke/trouble.nvim"] = {
    disable = true,
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "omareloui.config.trouble"
    end,
  },

  -- scrollbar
  ["petertriho/nvim-scrollbar"] = {
    config = function()
      require "omareloui.config.scrollbar"
    end,
  },
}

return M
