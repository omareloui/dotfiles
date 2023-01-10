M = { "lewis6991/gitsigns.nvim" }

M.config = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  local options = {
    signs = {
      add = { hl = "DiffAdd", text = "│" },
      change = { hl = "DiffChange", text = "│" },
      delete = { hl = "DiffDelete", text = "_" },
      topdelete = { hl = "DiffDelete", text = "‾" },
      changedelete = { hl = "DiffChangeDelete", text = "–" },
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
