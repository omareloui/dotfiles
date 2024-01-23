local c = require "omareloui.config.ui.palette"
local i = require "omareloui.config.ui.icons"

local dim_color = c.surface1
local modified_color = c.magenta

local function get_diagnostic_label(props)
  local icons = i.informative_diagnostics

  local label = {}
  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })

    local fg = dim_color

    if props.focused then
      local hl = vim.api.nvim_get_hl(0, { name = "DiagnosticSign" .. severity })
      fg = string.format("#%06x", hl.fg or hl.guifg)
    end

    if n > 0 then
      table.insert(label, { icon .. " " .. n .. " ", guifg = fg })
    end
  end
  return label
end

return {
  "b0o/incline.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  enabled = false,
  opts = {
    window = {
      margin = {
        horizontal = 1,
        vertical = 2,
      },
    },
    highlight = {
      groups = {
        InclineNormal = { guibg = "#00000000" },
        InclineNormalNC = { guibg = "#00000000" },
      },
    },
    render = function(props)
      local bufname = vim.api.nvim_buf_get_name(props.buf)
      local filename = vim.fn.fnamemodify(bufname, ":t")
      local diagnostics = get_diagnostic_label(props)
      local is_modified = vim.api.nvim_get_option_value("modified", { buf = props.buf })
      local modified = is_modified and "bold,italic" or "None"

      local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)

      local icon_color = props.focused and color or dim_color
      local label_color = props.focused and c.text or dim_color

      local buffer = {
        { filetype_icon, guifg = icon_color },
        { " " },
        { filename, gui = modified, guifg = label_color },
      }

      if is_modified then
        table.insert(buffer, { " " .. i.incline.modified, guifg = props.focused and modified_color or dim_color })
      end

      if #diagnostics > 0 then
        table.insert(diagnostics, { "| ", guifg = "grey" })
      end
      for _, buffer_ in ipairs(buffer) do
        table.insert(diagnostics, buffer_)
      end

      return diagnostics
    end,
  },
}
