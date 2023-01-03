M = {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  local present, regexplainer = pcall(require, "regexplainer")

  if not present then
    return
  end

  regexplainer.setup {
    mappings = require("omareloui.config.mappings").regexplainer(),
    popup = {
      border = {
        text = { top = "Regexplainer" },
        padding = { 0, 1 },
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
  }
end

return M
