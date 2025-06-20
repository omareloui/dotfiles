return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,
    dependencies = {
      {
        "HiPhish/rainbow-delimiters.nvim",
        enabled = true,
        config = function()
          require("rainbow-delimiters.setup").setup {}
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled = true,
        config = function()
          local move = require "nvim-treesitter.textobjects.move" ---@type table<string,fun(...)>
          local configs = require "nvim-treesitter.configs"
          for name, fn in pairs(move) do
            if name:find "goto" == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find "[%]%[][cC]" then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")

      -- stylua: ignore
      if not ok then return end
      local opts = {
        auto_install = true,
        highlight = {
          enable = true,
          highlight = { enable = true },
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = true },
        rainbow = { enable = true },
        ensure_installed = {
          "angular",
          "astro",
          "bash",
          "diff",
          "dockerfile",
          "eex",
          "elixir",
          "heex",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "query",
          "regex",
          "ron",
          "rust",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space><C-Space>",
            node_incremental = "<C-Space>",
            node_decremental = "<BS>",
            scope_incremental = false,
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
          select = {
            enable = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "select outer part of a function" },
              ["if"] = { query = "@function.inner", desc = "select inner part of a function" },

              ["ic"] = { query = "@class.inner", desc = "select inner part of a class" },
              ["ac"] = { query = "@class.outer", desc = "select outer part of a class" },

              ["il"] = { query = "@loop.inner", desc = "select inner part of a loop" },
              ["al"] = { query = "@loop.outer", desc = "select outer part of a loop" },

              ["ii"] = { query = "@conditional.inner", desc = "select inner part of a conditional" },
              ["ai"] = { query = "@conditional.outer", desc = "select outer part of a conditional" },

              ["ib"] = { query = "@block.inner", desc = "select inner part of a block" },
              ["ab"] = { query = "@block.outer", desc = "select outer part of a block" },

              ["ir"] = { query = "@parameter.inner", desc = "select inner part of a parameter" },
              ["ar"] = { query = "@parameter.outer", desc = "select outer part of a parameter" },
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = { query = "@parameter.inner", desc = "swap with the next parameter" } },
            swap_previous = {
              ["<leader>A"] = { query = "@parameter.inner", desc = "swap with the previous parameter" },
            },
          },
        },
      }

      configs.setup(opts)

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html" },
        callback = function()
          vim.treesitter.start(nil, "angular")
        end,
      })
    end,
  },

  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
}
