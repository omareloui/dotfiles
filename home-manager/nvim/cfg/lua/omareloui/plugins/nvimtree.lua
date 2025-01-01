return {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  event = "VeryLazy",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  config = function()
    local present, nvimtree = pcall(require, "nvim-tree")

    if not present then
      return
    end

    local options = {
      filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
        custom = {
          "^\\.git$",
          "^\\.stfolder.*",
          "^\\.obsidian$",
        },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      update_cwd = true,
      update_focused_file = {
        enable = false,
        update_cwd = false,
      },
      view = {
        adaptive_size = true,
        width = {
          min = 25,
          max = 55,
        },
        side = "right",
      },
      git = {
        enable = false,
        ignore = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = "none",

        indent_markers = {
          enable = false,
        },

        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,
          },

          glyphs = {
            default = "",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      tab = {
        sync = {
          close = true,
        },
      },
    }

    local set = require("omareloui.util.keymap").set
    set("<leader>ee", "<Cmd>NvimTreeToggle<CR>", "Toggle NvimTree")
    set("<leader>ef", "<Cmd>NvimTreeFindFileToggle<CR>", "Toggle NvimTree with focusing over the current file")
    set("<leader>ec", "<Cmd>NvimTreeCollapse<CR>", "Collapse file NvimTree")
    set("<leader>er", "<Cmd>NvimTreeReload<CR>", "Reloads NvimTree")

    vim.g.nvimtree_side = options.view.side
    nvimtree.setup(options)

    local ok, wk = pcall(require, "which-key")

    -- stylua: ignore
    if not ok then return end

    wk.add { { "<leader>e", group = "file tree" } }
  end,
}
