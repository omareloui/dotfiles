local ok, lualine = pcall(require, "lualine")

if not ok or vim.g.vscode then return end

lualine.setup()
