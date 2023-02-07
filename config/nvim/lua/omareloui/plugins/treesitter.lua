M = {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
  build = ":TSUpdate",
}

M.config = function()
  local present, treesitter = pcall(require, "nvim-treesitter.configs")

  if not present then
    return
  end

  local text_objects_mappings = require("omareloui.config.mappings").treesitter_text_objects

  local options = {
    ensure_installed = "all",
    indent = { enable = true },
    highlight = {
      enable = true,
      use_languagetree = true,
    },

    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "<CR>",
    --     scope_incremental = "<TAB>",
    --     node_incremental = "<CR>",
    --     node_decremental = "<S-TAB>",
    --   },
    -- },

    rainbow = {
      enable = true,
      extended_mode = false,
    },

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
  }

  treesitter.setup(options)
end

return M
