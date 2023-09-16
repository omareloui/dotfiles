local M = {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  enabled = false,
}

function M.config()
  local present, noice = pcall(require, "noice")

  if not present then
    return
  end

  require("notify").setup { background_colour = "#00000000" }

  local opts = { lsp = { signature = { enabled = false } } }

  noice.setup(opts)
end

return M
