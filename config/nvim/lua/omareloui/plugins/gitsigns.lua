M = { "lewis6991/gitsigns.nvim" }

M.config = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  -- TODO:
  -- require("base46").load_highlight "git"

  local options = {
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
    },
    on_attach = function(bufnr)
      require("omareloui.config.mappings").gitsings()
    end
  }

  gitsigns.setup(options)
end

return M
