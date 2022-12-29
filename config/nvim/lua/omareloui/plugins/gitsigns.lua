M = { "lewis6991/gitsigns.nvim" }

M.config = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  local options = {
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
      untracked = { hl = "DiffAdd" },
    },
    on_attach = function()
      require("omareloui.config.mappings").gitsings()
    end,
  }

  require("omareloui.ui.highlights").gitsings()

  gitsigns.setup(options)
end

return M
