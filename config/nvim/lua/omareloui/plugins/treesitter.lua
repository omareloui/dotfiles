local M = {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

M.config = function()
  local present, treesitter = pcall(require, "nvim-treesitter.configs")

  if not present then
    return
  end

  local text_objects_mappings = require("omareloui.config.mappings").treesitter_text_objects

  local options = {
    ensure_installed = {
      "html",
      "css",
      "scss",
      "javascript",
      "typescript",
      "astro",
      "json",
      "vue",
      "json",
      "json5",
      "jsonc",
      "lua",
      "rust",
      "elixir",
      "awk",
      "bash",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "glsl",
      "http",
      "jq",
      "luadoc",
      "markdown",
      "markdown_inline",
      "prisma",
      "python",
      "sql",
      "toml",
      "vim",
      "xml",
    },

    auto_install = true,

    indent = { enable = true },

    highlight = { enable = true },

    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "<CR>",
    --     scope_incremental = "<TAB>",
    --     node_incremental = "<CR>",
    --     node_decremental = "<S-TAB>",
    --   },
    -- },

    -- rainbow = { enable = false, extended_mode = false },

    autotag = {
      enable = true,
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
        "astro",
      },
    },

    textobjects = {
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

    context_commentstring = { enable = true },
  }

  treesitter.setup(options)
end

return M
