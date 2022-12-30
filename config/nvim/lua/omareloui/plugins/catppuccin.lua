M = { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 }

M.config = function()
  local present, catppuccin = pcall(require, "catppuccin")

  if not present then
    return
  end

  catppuccin.setup {
    flavour = "mocha",
    integrations = {
      cmp = true,
      -- dashboard = true,
      gitsigns = false,
      -- harpoon = true,
      lsp_saga = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      nvimtree = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      native_lsp = { enabled = true },
    },
  }

  vim.cmd.colorscheme "catppuccin"
end

return M