return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  init = require("omareloui.config.mappings").telescope,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
  },

  config = function()
    local present, telescope = pcall(require, "telescope")

    if not present then
      return
    end

    local trouble = require "trouble.providers.telescope"

    local options = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", ".*%.git/.*$" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        color_devicons = true,
        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,
            ["<C-q>"] = trouble.open_with_trouble,
          },
          i = {
            ["<C-q>"] = trouble.open_with_trouble,
          },
        },
      },
    }

    telescope.setup(options)
  end,
}
