local text_objects_mappings = require("omareloui.config.mappings").treesitter_text_objects

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile" },
    build = ":TSUpdate",
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
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
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { text_objects_mappings.node_incremental, desc = "Increment selection" },
      { text_objects_mappings.node_decremental, desc = "Decrement selection", mode = "x" },
    },
    config = function()
      local opts = {
        auto_install = true,
        autotag = { enable = true },
        highlight = { enable = true, additional_vim_regex_highlighting = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "lua",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "ron",
          "rust",
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
            init_selection = text_objects_mappings.init_selection,
            node_incremental = text_objects_mappings.node_incremental,
            node_decremental = text_objects_mappings.node_decremental,
            scope_incremental = false,
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = text_objects_mappings.goto_next_start,
            goto_next_end = text_objects_mappings.goto_next_end,
            goto_previous_start = text_objects_mappings.goto_previous_start,
            goto_previous_end = text_objects_mappings.goto_previous_end,
          },
          select = {
            enable = true,
            keymaps = text_objects_mappings.select,
          },
          swap = {
            enable = true,
            swap_next = text_objects_mappings.swap.next,
            swap_previous = text_objects_mappings.swap.prev,
          },
        },
      }

      require("nvim-treesitter.configs").setup(opts)
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
    opts = {},
  },
}
