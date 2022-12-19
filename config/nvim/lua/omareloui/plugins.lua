M = {
  ------- override configs -------

  -- enable alpha nvim
  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  -- enable which key
  ["folke/which-key.nvim"] = {
    disable = false,
  },

  -- override nvimtree configs
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      view = {
        side = "right",
      },
    },
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

  ------- my plugins -----

  -- formatter
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "omareloui.config.null_ls"
    end,
  },

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

  -- persist the vim session
  ["rmagatti/auto-session"] = {
    config = function()
      require "omareloui.config.auto_session"
    end,
  },

  -- transparent nvim
  ["xiyaowong/nvim-transparent"] = {
    config = function()
      require "omareloui.config.transparent"
    end,
  },
}

return M
