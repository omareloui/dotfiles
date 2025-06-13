return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
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

    local has_trouble_plugin = require "omareloui.util.has_plugin" "trouble.nvim"

    local mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
      },
      i = {},
    }

    if has_trouble_plugin then
      local trouble = require "trouble.sources.telescope"
      mappings.n["<C-q>"] = trouble.open
      mappings.i["<C-q>"] = trouble.open
    end

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
        file_ignore_patterns = {
          "node_modules",
          ".cache",
          "__pycache__",
          "venv",
          ".*%.git/.*$",
          ".output",
          ".nuxt",
          "vendor",
          "dist",
          "build",
          "^bazel-.*/",
        },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        color_devicons = true,
        mappings = mappings,
      },
    }

    telescope.setup(options)

    local set = require("omareloui.util.keymap").set

    -- stylua: ignore start
    set("<leader>ff", "<Cmd>Telescope find_files follow=true hidden=true<CR>", "Find files")
    set("<leader>fa", "<Cmd>Telescope find_files follow=true hidden=true no_ignore=true<CR>", "Find all")
    set("<leader>fo", "<Cmd>Telescope oldfiles<CR>", "Find in recent opened files")
    set("<leader>fw", "<Cmd>Telescope live_grep<CR>", "Live grep")
    set("<leader>fb", "<Cmd>Telescope buffers<CR>", "Search in buffers")
    set("<leader>fh", "<Cmd>Telescope help_tags<CR>", "Find in help tags")
    set("<leader>fk", "<Cmd>Telescope keymaps<CR>", "Show key mappings")
    set("<leader>fn", "<Cmd>Telescope file_browser files=false hide_parent_dir=true<CR>", "Open file browser")
    set("<leader>fr", "<Cmd>Telescope file_browser cwd=~/repos<CR>", "Open all repos")
    -- set("<leader>ft", "<Cmd>Telescope file_browser hidden=true repect_gitignore=false collapse_dirs=true<CR>", "Open file browser")
    -- stylua: ignore end

    set("<leader>gs", "<Cmd>Telescope git_status<CR>", "Git status")

    local wk = require "which-key"
    wk.add { { "<leader>f", group = "find" } }
  end,
}
