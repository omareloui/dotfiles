local ok, nvim_tree = pcall(require, "nvim-tree")

if not ok or vim.g.vscode then return end

nvim_tree.setup({
  -- hijack_netrw = false,
  view = {
    side = "right"
  }
})
