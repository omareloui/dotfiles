return {
  "olexsmir/gopher.nvim",
  ft = { "go" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local ok, gopher = pcall(require, "gopher")

    -- stylua: ignore
    if not ok then return end

    gopher.setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        local set = require("omareloui.util.keymap").set
        set("<leader>ct", "<Cmd>GoTagAdd<CR>", "Add json/yaml tags")
        set("<leader>cr", "<Cmd>GoTagRm<CR>", "Remove json/yaml tags")
        set("<leader>ci", "<Cmd>GoIfErr<CR>", 'Generate "if err" boilerplate')
      end,
    })
  end,
}
