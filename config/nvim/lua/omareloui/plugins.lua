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

  -- disable tabufline
  ["NvChad/ui"] = {
    override_options = {
      tabufline = {
        enabled = false,
      },
    },
  },

  -- override nvimtree configs
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      tab = {
        sync = {
          close = true,
        },
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      view = {
        adaptive_size = true,
        width = 25,
        hide_root_folder = true,
        side = "right",
        mappings = {
          list = {
            {
              key = { "<CR>", "o", "<2-LeftMouse>" },
              action = "tabnew",
              silent = true,
            },
          },
        },
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

  -- add config to cmp
  ["hrsh7th/nvim-cmp"] = {
    override_options = {
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "spell" },
      },
    },
  },

  ------- my plugins -----

  -- telescope
  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      local actions = require "telescope.actions"
      local fb_actions = require("telescope").extensions.file_browser.actions

      return {
        extensions_list = { "themes", "terms", "file_browser" },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            mappings = {
              n = {
                ["<CR>"] = actions.select_default,
              },
              i = {
                ["<CR>"] = actions.select_default,
              },
            },
          },
        },
        defaults = {
          -- initial_mode = "normal",
          mappings = {
            n = {
              ["q"] = actions.close,
              ["<CR>"] = actions.file_tab,
            },
            i = {
              ["<CR>"] = actions.file_tab,
            },
          },
        },
      }
    end,
  },

  ["nvim-telescope/telescope-file-browser.nvim"] = {},

  -- cmp
  ["f3fora/cmp-spell"] = {},

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
  ["tpope/vim-fugitive"] = {},

  -- persist the vim session
  ["rmagatti/auto-session"] = {
    config = function()
      require "omareloui.config.auto_session"
    end,
  },

  -- for my todos
  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "omareloui.config.todo_comments"
    end,
  },

  -- trouble (show problems of the file in a bar)
  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "omareloui.config.trouble"
    end,
  },
}

return M
