local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

-- TODO:
-- require("base46").load_highlight "treesitter"

local options = {
  ensure_installed = "all",
  indent = { enable = true },
  highlight = { enable = true, use_languagetree = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<TAB>",
      node_incremental = "<CR>",
      node_decremental = "<S-TAB>",
    },
  },
}

treesitter.setup(options)
