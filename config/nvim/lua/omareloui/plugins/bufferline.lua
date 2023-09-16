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

  local icons = require("omareloui.ui.icons").bufferline

  bufferline.setup {
    options = {
      modified_icon = icons.modefied,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count)
        return " " .. icons.diagnostics .. count
      end,
    },
  }
end

return M
