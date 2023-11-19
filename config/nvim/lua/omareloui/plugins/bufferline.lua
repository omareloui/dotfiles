local M = {
  "akinsho/bufferline.nvim",
  config = true,
  init = require("omareloui.config.mappings").bufferline,
}

function M.config()
  local present, bufferline = pcall(require, "bufferline")

  if not present then
    return
  end

  local icons = require("omareloui.config.ui.icons").bufferline
  local opts = {
    options = {
      modified_icon = icons.modefied,
      diagnostics = "nvim_lsp",
      component_separators = "|",
      section_separators = "",
      diagnostics_indicator = function(count)
        return " " .. icons.diagnostics .. count
      end,
    },
  }

  bufferline.setup(opts)
end

return M
