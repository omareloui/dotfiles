M = {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
  build = ":TSUpdate",
}

M.config = function()
  local present, treesitter = pcall(require, "nvim-treesitter.configs")

  if not present then
    return
  end

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

    rainbow = {
      enable = true,
    },
  }

  treesitter.setup(options)
end

return M
