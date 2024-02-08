return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  dependencies = { "kyazdani42/nvim-web-devicons" },

  config = function()
    local present, lualine = pcall(require, "lualine")

    if not present then
      return
    end

    local c = require "omareloui.config.ui.palette"
    local i = require "omareloui.config.ui.icons"
    local i_lualine = i.lualine

    lualine.setup {
      options = {
        -- globalstatus = true,
        -- icons_enabled = true,
        disabled_filetypes = { "alpha", "dashboard" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            -- color = function()
            --   return { bg = mode_color[vim.fn.mode()] }
            -- end,
            -- separator = { right = sep.right },
          },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
            color = { bg = c.surface0, fg = c.magenta },
            -- separator = { right = sep.right },
          },
          {
            "diff",
            colored = true,
            symbols = i_lualine.diff,
            color = { bg = c.surface0 },
            -- separator = { left = sep.left, right = sep.right },
          },
        },

        lualine_c = {
          -- {
          --   "diagnostics",
          --   sources = { "nvim_diagnostic" },
          --   sections = { "info", "error", "warn", "hint" },
          --   symbols = {
          --     info = i.diagnostics.Info,
          --     error = i.diagnostics.Error,
          --     warn = i.diagnostics.Warn,
          --     hint = i.diagnostics.Hint,
          --   },
          --   colored = true,
          --   always_visible = false,
          -- },
        },

        lualine_x = {
          {
            function()
              return i_lualine.lsp
            end,
            -- separator = { left = sep.left, right = sep.right },
            -- separator = { left = sep.left },
            color = { bg = c.magenta, fg = c.black },
          },
        },

        lualine_y = {},

        lualine_z = {},
      },
    }
  end,
}
