return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "AndreM222/copilot-lualine",
  },

  config = function()
    local present, lualine = pcall(require, "lualine")

    -- stylua: ignore
    if not present then return end

    local lazy_status = require "lazy.status"
    local c = require "omareloui.config.ui.palette"
    local i = require("omareloui.config.ui.icons").lualine

    ---@param color string
    local function get_theme(color)
      return {
        a = { bg = color, fg = c.crust, gui = "bold" },
        b = { bg = c.surface0, fg = c.text },
        c = { bg = c.base, fg = c.text },
      }
    end

    local theme = {
      normal = get_theme(c.blue),
      insert = get_theme(c.green),
      visual = get_theme(c.magenta),
      command = get_theme(c.yellow),
      replace = get_theme(c.red),
      inactive = {
        a = { bg = c.surface0, fg = c.subtext0, gui = "bold" },
        b = { bg = c.surface0, fg = c.subtext0 },
        c = { bg = c.surface0, fg = c.subtext0 },
      },
    }

    lualine.setup {
      options = {
        theme = theme,
        globalstatus = true,
        icons_enabled = true,
        disabled_filetypes = {
          "alpha",
          "dashboard",
          "NvimTree",
          "oil",
          "Trouble",
        },
        ignore_focus = {
          "toggleterm",
          "lazy",
          "help",
          "mason",
          "lspinfo",
          "TelescopePrompt",
        },
        always_divide_middle = true,
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          { "diff", symbols = i.git },
          "diagnostics",
        },
        lualine_c = {
          {
            "filename",
            path = 4,
            shorting_target = 40,
            symbols = i.file_symbols,
          },
        },

        lualine_x = {
          { "copilot", show_colors = true },
          { lazy_status.updates, cond = lazy_status.has_updates, color = { fg = c.yellow } },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
