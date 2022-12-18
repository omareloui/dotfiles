local ok, transparent = pcall(require, "transparent")

if not ok or vim.g.vscode then return end

require("transparent").setup({
  enable = true,
  extra_groups = {
    "all"
  },
  exclude = {},
})
